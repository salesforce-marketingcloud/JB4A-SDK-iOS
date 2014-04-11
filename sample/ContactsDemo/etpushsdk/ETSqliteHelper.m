//
//  ETSqliteHelper.m
//  ET SDK Demo
//
//  Created by Eddie Roger on 7/15/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//
// #if !__has_feature(objc_arc)

#import "ETSqliteHelper.h"
#import "sqlite3.h"

static ETSqliteHelper *database = nil;

@implementation ETSqliteHelper

@synthesize maxRetries = _maxRetries;

+(ETSqliteHelper *)database
{
    @synchronized(self)
    {
        if (database == nil) {
            database = [[self alloc] init];
        }
    }
    
    return database;
}

-(id)init
{
    if (self = [super init]) {
        _db = nil;
        _maxRetries = 5;
        [self open];
    }
    
    return self;
}

-(void)dealloc
{
    [self close];
    
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

-(BOOL)open
{
    [self close];
    
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *finalPath = [paths stringByAppendingPathComponent:@"etdb.db"];
    NSLog(@"Final Path: %@", finalPath);
    if (sqlite3_open([finalPath fileSystemRepresentation], &_db) != SQLITE_OK) {
        ETLog(@"Errored opening SQLite DB: %s", sqlite3_errmsg(_db));
        return NO;
    }
    
    return YES;
}

-(void)close
{
    if (_db == nil) return;
    
    int numberOfRetries = 0;
    int rc;
    
    while (true) {
        rc = sqlite3_close(_db);
        if (rc == SQLITE_OK) {
            _db = nil;
            break;
        }
        
        if (rc == SQLITE_BUSY) {
            if (numberOfRetries++ >= _maxRetries) {
                ETLog(@"SQLite too busy. Unable to close DB.");
                break;
            }
        [NSThread sleepForTimeInterval:0.01];
        } else {
            ETLog(@"Error closing ET Local DB: %s", sqlite3_errmsg(_db));
            break;
        }
    }
}

-(NSString *)lastErrorMessage
{
    return [NSString stringWithFormat:@"%s", sqlite3_errmsg(_db)];
}

-(NSInteger) lastErrorCode
{
    return sqlite3_close(_db);
}

-(NSInteger)rowsAffected
{
    return sqlite3_changes(_db);
}

-(BOOL)prepareSql:(NSString *)sql inStatement:(sqlite3_stmt **)stmt
{
    int numberOfRetries = 0;
    int result;
    
    while (true)
    {
        result = sqlite3_prepare_v2(_db, [sql UTF8String], -1, stmt, NULL);
        
        if (result == SQLITE_OK) return YES;
        
        if (result == SQLITE_BUSY) {
            if (numberOfRetries++ >= _maxRetries) {
                ETLog(@"Sqlite too busy to prepare SQL.");
                break;
            }
            [NSThread sleepForTimeInterval:0.01];
        } else {
            ETLog(@"Failed to prepare SQL: %s", sqlite3_errmsg(_db));
            ETLog(@"Query was: %@", sql);
            break;
        }
    }
    
    return NO;
}

-(BOOL)executeStatement:(sqlite3_stmt *)stmt
{
    int numberOfRetries = 0;
    int result;
    
    while (true) {
        result = sqlite3_step(stmt);
        
        if (result == SQLITE_OK || result == SQLITE_DONE) return YES;
        
        if (result == SQLITE_BUSY) {
            if (numberOfRetries++ >= _maxRetries) {
                ETLog(@"Sqlite too busy to execute statement.");
                break;
            }
            [NSThread sleepForTimeInterval:0.01];
        } else {
            ETLog(@"Sqlite step failed: %s", sqlite3_errmsg(_db));
            break;
        }
    }
    
    return NO;
}

-(void)bindObject:(id)obj toColumn:(int)idx inStatement:(sqlite3_stmt *)stmt
{
    if (obj == nil || obj == [NSNull null]) { // Nulls
        sqlite3_bind_null(stmt, idx);
        
    } else if ([obj isKindOfClass:[NSData class]]) { // Data as blob
        sqlite3_bind_blob(stmt, idx, [obj bytes], [obj length], SQLITE_STATIC);
        
    } else if ([obj isKindOfClass:[NSDate class]]) { // Date as seconds since epoch
        sqlite3_bind_double(stmt, idx, [obj timeIntervalSince1970]);
        
    } else if ([obj isKindOfClass:[NSNumber class]]) { // Number wrapper, because there are a lot of them
        if (!strcmp([obj objCType], @encode(BOOL))) { // Boolean
            sqlite3_bind_int(stmt, idx, [obj boolValue] ? 1 : 0);
            
        } else if (!strcmp([obj objCType], @encode(int))) { // Integer
            sqlite3_bind_int64(stmt, idx, [obj longValue]);
            
        } else if (!strcmp([obj objCType], @encode(long))) { // Long
            sqlite3_bind_int64(stmt, idx, [obj longValue]);
            
        } else if (!strcmp([obj objCType], @encode(float))) { // Float
            sqlite3_bind_double(stmt, idx, [obj floatValue]);
            
        } else if (!strcmp([obj objCType], @encode(double))) { // Double
            sqlite3_bind_double(stmt, idx, [obj doubleValue]);
            
        } else { // It's a kind of number we don't know. I guess it could happen.
            sqlite3_bind_text(stmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
            
        }
    } else {
        sqlite3_bind_text(stmt, idx, [[obj description] UTF8String], -1, SQLITE_STATIC);
    }
}

-(BOOL)hasNext:(sqlite3_stmt *)stmt
{
    int numberOfRetries = 0;
    int result;
    
    while (true) {
        result = sqlite3_step(stmt);
        
        if (result == SQLITE_ROW) return YES;
        
        if (result == SQLITE_DONE) break;
        
        if (result == SQLITE_BUSY) {
            if (numberOfRetries++ >= _maxRetries) {
                ETLog(@"Sqlite too busy to return next.");
                break;
            }
            [NSThread sleepForTimeInterval:0.01];
        } else {
            ETLog(@"Sqlite prepare failed: %s", sqlite3_errmsg(_db));
        }
    }
    
    return NO;
}

-(id)columnData:(sqlite3_stmt *)stmt columnIndex:(NSInteger)idx
{
    int columnDataType = sqlite3_column_type(stmt, idx);
    const unsigned char *txt;
    int nBytes;
    const char *bytes;
    
    switch (columnDataType) {
        case SQLITE_NULL:
            return [NSNull null];
            break;
            
        case SQLITE_INTEGER:
            return [NSNumber numberWithInt:sqlite3_column_int(stmt, idx)];
            break;
            
        case SQLITE_FLOAT:
            return [NSNumber numberWithDouble:sqlite3_column_double(stmt, idx)];
            break;
            
        case SQLITE_TEXT:
            txt = sqlite3_column_text(stmt, idx);
            return [NSString stringWithFormat:@"%s", txt];
            break;
            
        case SQLITE_BLOB:
            nBytes = sqlite3_column_bytes(stmt, idx);
            bytes = sqlite3_column_bytes(stmt, idx);
            return [NSData dataWithBytes:bytes length:nBytes];
        
        default:
            return nil;
            break;
    }
}

-(NSString *)columnName:(sqlite3_stmt *)stmt columnIndex:(NSInteger)idx
{
    return [NSString stringWithUTF8String:sqlite3_column_name(stmt, idx)];
}

-(NSArray *)executeQuery:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);
    
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    NSUInteger i;
    
    for (i = 0; i < [sql length]; i++) {
        if ([sql characterAtIndex:i] == '?') {
            [arguments addObject:va_arg(args, id)];
        }
    }
    
    va_end(args);
    
    NSArray *result = [self executeQuery:sql arguments:arguments];
    
#if !__has_feature(objc_arc)
    [arguments release];
#endif
    
    return result;
}

-(NSArray *)convertResultSet:(sqlite3_stmt *)stmt
{
    NSMutableArray *resultSet = [[NSMutableArray alloc] init];
    
    int numberOfColumns = sqlite3_column_count(stmt);
    
    while ([self hasNext:stmt]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (int x = 0; x < numberOfColumns; x++) {
            [dict setObject:[self columnData:stmt columnIndex:x]
                     forKey:[self columnName:stmt columnIndex:x]];
        }
        [resultSet addObject:dict];
    }

#if !__has_feature(objc_arc)
    return [resultSet autorelease];
#else
    return resultSet;
#endif
}

-(NSArray *)executeQuery:(NSString *)sql arguments:(NSArray *)args
{
    sqlite3_stmt *stmt;
    
    if (![self prepareSql:sql inStatement:(&stmt)]) {
        return nil;
    }
    
    int x = 1;
    int paramCount = sqlite3_bind_parameter_count(stmt);
    for (; x <= paramCount; x++) {
        [self bindObject:[args objectAtIndex:(x-1)] toColumn:x inStatement:stmt];
    }
    
    NSArray *result = [self convertResultSet:stmt];
    sqlite3_finalize(stmt);
    
    return result;
}

-(BOOL)executeUpdate:(NSString *)sql, ...
{
    int numberOfArgsFound = 0;
    
    va_list args;
    va_start(args, sql);
    
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    NSUInteger x;
    
    for (x = 0; x < [sql length]; x++) {
        if ([sql characterAtIndex:x] == '?') {
            numberOfArgsFound++;
            id arg = va_arg(args, id);

            if (!arg) {
                ETLog(@"Failed to update. Missing value in query for position %d", x);
                
#if !__has_feature(objc_arc)
                [arguments release];
#endif
                return NO;
            }
            [arguments addObject:arg];
        }
    }
    
    va_end(args);
    
    BOOL result = [self executeUpdate:sql arguments:arguments];

#if !__has_feature(objc_arc)
    [arguments release];
#endif
    
    return result;
}

-(BOOL)executeUpdate:(NSString *)sql arguments:(NSArray *)arguments
{
    sqlite3_stmt *stmt;
    
    if (![self prepareSql:sql inStatement:(&stmt)]) {
        return NO;
    }
    
    int x = 1;
    int paramCount = sqlite3_bind_parameter_count(stmt);
    
    if (paramCount != arguments.count) {
        ETLog(@"== ERROR == The number of arguments passed to executeUpdate:arguments: does not match the expected number in the query. Expected count: %d, Actual count: %d", paramCount, arguments.count);
        return NO;
    }
    
    for (; x <= paramCount; x++) {
        [self bindObject:[arguments objectAtIndex:(x-1)] toColumn:x inStatement:stmt];
    }
    
    BOOL result = [self executeStatement:stmt];
    
    sqlite3_finalize(stmt);
    return result;
}

-(BOOL)tableExists:(NSString *)tableName
{
    NSString *tbl = [tableName uppercaseString];
    NSArray *results = [self executeQuery:@"select sql from sqlite_master where type = 'table' and upper(name) = ?;", tbl];
    if (results.count > 0) {
        return YES;
    } else {
        return NO;
    }
    
}

#pragma mark - Transactions
-(BOOL)beginTransaction
{
    return [self executeUpdate:@"BEGIN EXCLUSIVE TRANSACTION"];
}

-(BOOL)commitTransaction
{
    return [self executeUpdate:@"COMMIT TRANSACTION"];
}

-(BOOL)rollbackTransaction
{
    return [self executeUpdate:@"ROLLBACK TRANSACTION"];
}

@end

//
//  ETSqliteHelper.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 7/15/13.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"

/**
 This is a lightweight SQLite wrapper that handles database interaction. It is only used privately, and shouldn't be used by others. 
 
  Most of the methods are self-explainatory, so this class isn't heavily documented.
 */
@interface ETSqliteHelper : NSObject
{
    sqlite3 *_db;
}

@property (nonatomic) NSInteger maxRetries;

-(instancetype)init;
+(instancetype)database;

-(BOOL)open;
-(void)close;

-(NSString *)lastErrorMessage;
-(NSInteger)lastErrorCode;
-(NSInteger)rowsAffected;

-(NSArray *)executeQuery:(NSString *)sql, ... __attribute__((deprecated));
-(NSArray *)executeQuery:(NSString *)sql arguments:(NSArray *)args;

-(BOOL)executeUpdate:(NSString *)sql, ... __attribute__((deprecated));
-(BOOL)executeUpdate:(NSString *)sql arguments:(NSArray *)arguments;

-(BOOL)tableExists:(NSString *)tableName;

-(BOOL)beginTransaction;
-(BOOL)commitTransaction;
-(BOOL)rollbackTransaction;


@end

Push Constants
==============

To ensure consistency in implementation and ease development, a set of constants are used inside of the Journey Builder for Apps SDK. Below is a definition of each and rationale for their usage. 


ETData Request Notifications Constants
--- 
These notifications are sent as part of the request lifecycle for data requests to the MobilePush server only.

### ETRequestComplete
Sent when the data request has finished successfully. This ends the flow.

### ETRequestFailed
Sent on a generic or unknown failure. 

### ETRequestFailedOnLoadingResult  
Sent if the parser is unable to understand the data sent back by Salesforce

### ETRequestFinishedWithFailure   
Sent if the call to the MobilePush service fails. This indicates the end of a request flow that has ended in a failed state.

### ETRequestNoData
Sent if a request is made without providing the App Data dictionary. 

### ETRequestServiceResponseSuccess 
Sent if the MobilePush service returns a success code (201), but the result has not yet been processed. 

### ETRequestServiceReturnedError   
Sent if the MobilePush service returns an error (either 4xx or 5xx).

###ETRequestStarted
Sent when the initial request is sent to MobilePush.

Fuel Auth Token Notification Constants
---
These notifications are sent during the access token portion of the flow. An access token is required to make a request to any service at Salesforce, and use the Client ID and Secret provided during app configuration. 

For more information, please check [code@ExactTarget](http://code.exacttarget.com).

### ETAuthRequestFailed 
Sent if the request to the auth service has failed. 

### ETAuthRequestFinishedWithFailure 
Sent if the auth request has reached a failed state and is unable to continue. Without a token, the subsequent calls can not be made. This indicates the end of the flow, and if received, the data should be considered not successfully sent to Salesforce. 

### ETAuthRequestStarted            
Sent at the beginning of the authentication flow. This will not be sent if a token is saved and not required. 

### ETAuthRequestSuccess            
Sent when an accessToken has been received by the Fuel Auth server. This is the end of the authentication flow, and is an indicator of success. 


NSUserDefaults Key Constants
---
These constants are used to store and retrieve data from NSUserDefaults.

### ETFuelAuthToken 
The string of the accessToken as received by Fuel. 

### ETFuelAuthTokenExpiration 
An NSDate object indicating token invalidation. It is set to 55 minutes after the token was received. If the current time [NSDate date] is after this time, a new token should be requested. 
//  Copyright 2015 Microsoft Corporation
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "ODAADAccountBridge.h"
#import "ADUserInformation.h"
#import "ADTokenCacheStoreItem.h"
#import "ODAccountSession.h"
#import "ODServiceInfo.h"

@implementation ODAADAccountBridge

+ (ADTokenCacheStoreItem *)cacheItemFromAccountSession:(ODAccountSession *)account
{
    NSParameterAssert(account);
    
    ADTokenCacheStoreItem *cacheItem = [[ADTokenCacheStoreItem alloc] init];
    cacheItem.clientId = account.serviceInfo.appId;
    cacheItem.authority = account.serviceInfo.authorityURL;
    cacheItem.resource = account.serviceInfo.resourceId;
    cacheItem.accessToken = account.accessToken;
    cacheItem.refreshToken = account.refreshToken;
    cacheItem.expiresOn = account.expires;
    cacheItem.userInformation = [ADUserInformation userInformationWithUserId:account.accountId error:nil];
    return cacheItem;
}

+ (ODAccountSession *)accountSessionFromCacheItem:(ADTokenCacheStoreItem *)cacheStoreItem serviceInfo:(ODServiceInfo *)serviceInfo
{
    NSParameterAssert(cacheStoreItem);
    
    return [[ODAccountSession alloc] initWithId:cacheStoreItem.userInformation.userId
                                            accessToken:cacheStoreItem.accessToken
                                          expires:cacheStoreItem.expiresOn
                                          refreshToken:cacheStoreItem.refreshToken
                                          serviceInfo:serviceInfo];
}

@end

//  MIT License
//
//  Copyright (c) 2020 Thales DIS
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

// IMPORTANT: This source code is intended to serve training information purposes only.
//            Please make sure to review our IdCloud documentation, including security guidelines.

#include <UIKit/UIKit.h>
#import <EzioMobile/EzioMobile.h>

@interface Provisioning_Logic : NSObject

/**
 Asynchronous method to provision token based on user id and registration code from tutorial page.

 @param userId User id generated by tutorial page. It will be also used as token name.
 @param regCode Registration code generated by tutorial page.
 @param completionHandler Handler triggered once operation is finished.
 */
+ (void)provisionWithUserId:(NSString * _Nonnull)userId
           registrationCode:(id<EMSecureString> _Nonnull)regCode
          completionHandler:(void (^_Nonnull)(id<EMOathToken> _Nullable token, NSError * _Nullable error))completionHandler;


/**
 Method will return first provisioned token or nil if there is not any.

 @return Token or nil.
 */
+ (id<EMOathToken>_Nullable)token;


/**
 It will delete first provisioned token.

 @param error Error description
 @return YES if operation was succesfull.
 */
+ (BOOL)removeToken:(NSError *_Nullable*_Nullable)error;

@end

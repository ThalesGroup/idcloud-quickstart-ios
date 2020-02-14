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
#import "OTP.h"

@interface OTP_Value : NSObject

@property (nonatomic, strong, readonly) id<EMSecureString>  otp;
@property (nonatomic, assign, readonly) Lifespan            lifespan;


/**
 Constructor

 @param otp OTP Value
 @param lastLifespan Last OTP value life span since calculation.
 @param maxLifespan Maximum OTP value life span.
 @return New instance of OTP Value.
 */
+ (instancetype)valueWithOTP:(id<EMSecureString>)otp
                lastLifespan:(NSInteger)lastLifespan
                 maxLifespan:(NSInteger)maxLifespan;

/**
 Wipe all sensitive data.
 */
- (void)wipe;

@end

@interface OTP_Logic : NSObject

/**
 Method to generate One Time Password based on generic auth input.
 
 @param token Token from which we want to generate OTP.
 @param authInput Generic auth input object like Pin, FaceId etc..
 @param error Error description.
 @return One time password encapsulated in OTP_Value object.
 */
+ (OTP_Value *)generateOtp:(id<EMOathToken>)token
             withAuthInput:(id<EMAuthInput>)authInput
                     error:(NSError **)error;


@end

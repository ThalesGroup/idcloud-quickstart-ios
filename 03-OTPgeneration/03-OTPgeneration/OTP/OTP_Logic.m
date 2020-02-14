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

#import "OTP_Logic.h"
#import "ProtectorConfig.h"

@implementation OTP_Value

@synthesize otp = _otp, lifespan = _lifespan;

+ (instancetype)valueWithOTP:(id<EMSecureString>)otp
                lastLifespan:(NSInteger)lastLifespan
                 maxLifespan:(NSInteger)maxLifespan
{
    return [[OTP_Value alloc] initWithOTP:otp lastLifespan:lastLifespan maxLifespan:maxLifespan];
}

- (id)initWithOTP:(id<EMSecureString>)otp
     lastLifespan:(NSInteger)lastLifespan
      maxLifespan:(NSInteger)maxLifespan
{
    if (self = [super init]) {
        _otp                = otp;
        _lifespan.current   = lastLifespan;
        _lifespan.max       = maxLifespan;
    }
    
    return self;
}

- (void)wipe
{
    if (_otp) {
        [_otp wipe];
        _otp = nil;
    }
}

@end

@implementation OTP_Logic

+ (OTP_Value *)generateOtp:(id<EMOathToken>)token
             withAuthInput:(id<EMAuthInput>)authInput
                     error:(NSError *__autoreleasing *)error
{
    NSError     *internalErr = nil;
    OTP_Value   *retValue    = nil;
    
    do {
        // Detect jailbreak status.
        if (EMJailbreakDetectorGetJailbreakStatus() != EMJailbreakStatusNotJailbroken) {
            break;
        }
        
        // TODO: Get an instance of EMOathFactory from OathService
        
        // TODO: Create a EMMutableSoftOathSettings by means of the factory
        
        // TODO: Set OCRA suite from the Otp configuration stored in ProtectorConfig in first lesson
        
        // TODO: Create a EMOathDevice for the given token and EMSoftOathSettings settings
        
        // TODO: Use the OathDevice and PIN to generate time based OTP
        
        // TODO: Read the lifespan of the OTP from the OathDevice
        
        // TODO: Wrap the OTP and lifespan in a new instance of OtpResult
        
        // TODO: Don't forget to wipe the PIN
        
        // TODO: Return the OtpResult created
    } while (NO);
    
    // Something went wrong? Propagate error.
    if (internalErr && error) {
        *error = internalErr;
    }

    return retValue;
}

@end
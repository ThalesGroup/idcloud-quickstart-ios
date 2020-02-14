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
#include "MainViewProtocol.h"

@protocol ProvisionerViewDelegate <NSObject>

/**
 User triggered provision process.

 @param userId User identifier.
 @param regCode Registration code.
 */
- (void)onProvision:(NSString *)userId withRegistrationCode:(id<EMSecureString>)regCode;


/**
 Triggered when user decided to remove token.
 */
- (void)onRemoveToken;

@end

IB_DESIGNABLE
@interface ProvisionerView : UIView

@property (weak, nonatomic) id<MainViewProtocol, ProvisionerViewDelegate> delegate;

/**
 Update provisioning view with current status.

 @param enabled Enable / Disable UI.
 @param token Provisioned token.
 */
- (void)updateGUI:(BOOL)enabled token:(id<EMOathToken>)token;

@end

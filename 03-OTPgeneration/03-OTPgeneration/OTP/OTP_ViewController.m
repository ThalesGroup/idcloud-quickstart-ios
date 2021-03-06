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

#import "OTP_ViewController.h"
#import "Provisioning_Logic.h"
#import "OTP_Logic.h"

@interface OTP_ViewController()

@property (weak, nonatomic) IBOutlet UIButton   *buttonOTP;

@end

@implementation OTP_ViewController

// MARK: - Override

- (id<EMOathToken>)updateGUI
{
    // All token related error is solved in previous chapter.
    id<EMOathToken> token = [super updateGUI];
    
    // To make demo simple we will just disable / enable UI.
    [_buttonOTP setEnabled:![self loadingBarIsPresent] && token];
    
    // Hide OTP Result related value if user remove token.
    if (!token) {
        [_resultView hide];
    }

    return token;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // Hide current OTP Result related value.
    [_resultView hide];
}

// MARK: - Public API

- (void)generateAndDisplayOtp:(id<EMOathToken>)token authInput:(id<EMAuthInput>)authInput
{
    // Calculate OTP for given pin and display result.
    NSError     *internalErr    = nil;
    OTP_Value   *otpValue       = [OTP_Logic generateOtp:token
                                           withAuthInput:authInput
                                                   error:&internalErr];
    
    if (internalErr) {
        [self displayErrorIfPresent:internalErr];
    } else {
        [_resultView show:otpValue.otp.stringValue lifespan:otpValue.lifespan];
    }
    
    // All secure containers should be wiped asap.
    [authInput wipe];
    [otpValue wipe];
}

- (void)generateAndDisplayOtp_PinInput
{    
    // Display pin input dialog.
    [self userPinWithCompletionHandler:^(id<EMPinAuthInput> pin) {
        [self generateAndDisplayOtp:[Provisioning_Logic token] authInput:pin];
    }];
    
}

- (void)userPinWithCompletionHandler:(AuthPinHandler)completionHandler
{
    // TODO: create a EMSecureInputBuilder by means of EMSecureInputService
    
    // TODO: use buildWithScrambling method to prepare an instance of EMSecureInputUi
    // TODO: implement the ^(id<EMPinAuthInput> firstPin, id<EMPinAuthInput> secondPin) block
    
    // TODO: propagate EMPinAuthInput using the completionHandler
    // TODO: wipe the instance of the builder
    
    // TODO: wipe the instance of the builder
    // TODO: call [self.navigationController popViewControllerAnimated:YES]
    
    // TODO: use the instance of EMSecureInputUi to get and store UIViewController
    
    // TODO: show the UIViewController
}

// MARK: - User interface

- (IBAction)onButtonPressedGenerateOTP:(UIButton *)sender
{
    [self generateAndDisplayOtp_PinInput];
}

@end

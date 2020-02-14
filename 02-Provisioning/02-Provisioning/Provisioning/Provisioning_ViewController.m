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

#import "Provisioning_ViewController.h"
#import "Provisioning_Logic.h"
#import "LoadingIndicatorView.h"
#import "ProtectorConfig.h"

@interface Provisioning_ViewController()

@property (weak, nonatomic) IBOutlet LoadingIndicatorView *loadingIndicator;

@end

@implementation Provisioning_ViewController

// MARK: - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![EMCore isConfigured]) {
        NSError *error = nil;
        // OTP module is required for token management and OTP calculation.
        EMOtpConfiguration *otpCFG = [EMOtpConfiguration defaultConfiguration];
        
        // Configure core with given key and set of required modules.
        [EMCore configureWithActivationCode:CFG_ACTIVATION_CODE()
                             configurations:[NSSet setWithObject:otpCFG]];
        
        [[EMCore sharedInstance].passwordManager login:&error];
        // This should not happen. Usually it means, that someone try to login with different password than last time.
        assert(!error);
    }
    
    // Set provisioner UI delegate.
    _provisionView.delegate     = self;
    
    // Update UI availability
    [self updateGUI];
}

// MARK: - Private helpers

- (id<EMOathToken>)updateGUI
{
    // Get stored token
    id<EMOathToken> token = [Provisioning_Logic token];
    
    // To make demo simple we will just disable / enable UI.
    [_provisionView updateGUI:![self loadingBarIsPresent] token:token];
    
    // Pass token to all subclasses.
    return token;
}

// MARK: - ProvisionerViewDelegate

- (void)onProvision:(NSString *)userId withRegistrationCode:(id<EMSecureString>)regCode
{
    // Display loading message before asynchronous provisioning
    [self loadingBarShow:NSLocalizedString(@"STRING_PROVISION_LOADING", nil) animated:YES];
    
    // Provision
    [Provisioning_Logic provisionWithUserId:userId
                           registrationCode:regCode
                          completionHandler:^(id<EMOathToken> _Nullable token, NSError * _Nullable error)
     {
         // Wipe registration code. Since it's not needed any
         [regCode wipe];
         
         // Async operation finished. We can hide loading.
         [self loadingBarHide:YES];
         
         if (token) {
             [self displayResult:@"Provisioning was successfull."];
         } else if (error) {
             [self displayErrorIfPresent:error];
         } else {
             [self displayResult:@"Unknown error happened during provisioning."];
         }
     }];
}

- (void)onRemoveToken
{
    NSError *error = nil;
    if ([Provisioning_Logic removeToken:&error]) {
        [self updateGUI];
    }
    
    // Display any possible errors during token removal process.
    [self displayErrorIfPresent:error];

}

// MARK: - MainViewProtocol

- (NSString *)caption
{
    // Return application name based on plist configuration.
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
}

- (void)displayResult:(NSString *)result
{
    // Main alert builder.
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[self caption]
                                                                   message:result
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // Add basic OK button without any handlers.
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    
    // Present dialog.
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)displayErrorIfPresent:(NSError *)error
{
    // Use display error in case of error.
    if (error) {
        [self displayResult:error.localizedDescription];
    }
}

- (void)displayOnCancelDialog:(NSString *)message completionHandler:(void (^)(BOOL))handler
{
    // Main alert builder.
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[self caption]
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // Add ok button with handler.
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                handler(YES);
                                            }]];
    
    // Add cancel button with handler.
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                handler(NO);
                                            }]];
    
    // Present dialog.
    [self presentViewController:alert animated:true completion:nil];
    
}

- (BOOL)loadingBarIsPresent
{
    return _loadingIndicator.isPresent;
}

- (void)loadingBarShow:(NSString *)caption animated:(BOOL)animated
{
    [_loadingIndicator loadingBarShow:caption animated:animated];
    [self updateGUI];
}

- (void)loadingBarHide:(BOOL)animated
{
    [_loadingIndicator loadingBarHide:animated];
    [self updateGUI];
}

@end

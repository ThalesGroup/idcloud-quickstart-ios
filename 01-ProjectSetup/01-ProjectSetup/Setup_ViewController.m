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

#import "Setup_ViewController.h"
#import <EzioMobile/EzioMobile.h>
#import "ProtectorConfig.h"   

@interface Setup_ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelVersionOutlet;
@property (weak, nonatomic) IBOutlet UILabel *labelStatusOutlet;
@end

@implementation Setup_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_labelStatusOutlet setText:@"Configuration pending"];
}

- (IBAction)configureProtector:(id)sender {
    // TODO: check if the Protector's core module is already configured
    // TODO: prepare an OTP configuration
    // TODO: configure the Protector's core module
    // TODO: login to the password manager
    // TODO: get Mobile Protector SDK version
    NSString* version = @"get Version from SDK";
    // TODO: get Mobile Protector SDK version
    [_labelVersionOutlet setText:[NSString stringWithFormat:@"%@ %@", @"Mobile Protector SDK version: ", version]];
    [_labelStatusOutlet setText:@"Configured"];
}

@end

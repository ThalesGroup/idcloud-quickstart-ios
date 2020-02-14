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

#import "ResultView.h"

@interface ResultView()

@property (weak, nonatomic) IBOutlet UILabel        *labelOTP;
@property (weak, nonatomic) IBOutlet UIProgressView *progressOTP;

@end

@implementation ResultView

// MARK: - Life Cycle

- (nullable instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setupWithFrame:self.bounds];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupWithFrame:frame];
    }
    
    return self;
}

- (void)setupWithFrame:(CGRect)frame
{
    // Color is used as placeholder in case of disabled IB_DESIGNABLE
    self.backgroundColor = [UIColor clearColor];
    
    // Get our view from storyboard.
    UIView *contentView = [[[NSBundle bundleForClass:self.class] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil] firstObject];
    contentView.frame = frame;
    
    // Add it as child of current View.
    [self addSubview:contentView];
}

// MARK: - Public API

- (void)hide
{
    [_labelOTP      setText:@""];
    [_labelOTP      setHidden:YES];
    [_progressOTP   setHidden:YES];
    
    [_progressOTP.layer removeAllAnimations];
}

- (void)show:(NSString *)value lifespan:(Lifespan)lifespan
{
    // Ignore same values
    if ([_labelOTP.text isEqualToString:value]) {
        return;
    }
    
    // Finish all previous animations.
    for (CALayer *layer in _progressOTP.layer.sublayers) {
        [layer removeAllAnimations];
    }
    
    // Unhide OTP label and set default values
    [_labelOTP  setTextColor:[UIColor blackColor]];
    [_labelOTP  setHidden:NO];
    [_labelOTP  setText:value];

    // Unhide progress and set value to current remaining value.
    [_progressOTP   setHidden:NO];
    [_progressOTP   setProgress:(CGFloat)lifespan.current / (CGFloat)lifespan.max];
    [_progressOTP   layoutIfNeeded];

    // Animate time.
    [UIView animateWithDuration:(CGFloat)lifespan.current animations:^{
        self.progressOTP.progress = .0f;
        [self.progressOTP layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.labelOTP setTextColor:[UIColor grayColor]];
        }
    }];
}

@end

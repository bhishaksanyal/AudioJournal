//
//  Common.m
//  AudioJournal
//
//  Created by Bhishak Sanyal on 31/08/22.
//

#import "Common.h"
#import "SCNetworkReachability.h"

@implementation Common

#pragma mark - UI builder -

+ (void)createCircleWithView:(UIView *)view
{
    view.layer.cornerRadius = view.bounds.size.width / 2;
    view.layer.masksToBounds = YES;
}

+ (void)addShadowToView:(UIView *)view
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    view.layer.shadowOpacity = 0.2f;
    view.layer.shadowPath = shadowPath.CGPath;
}

+ (float)getCalculatedValueOfValue:(float)value calculated:(BOOL)calculated
{
    if(calculated) {
        return [UIScreen mainScreen].bounds.size.height * (value / 568.0);
    }else{
        return [UIScreen mainScreen].bounds.size.width * (value / 320.0);
    }
}

+ (void)addNavGradientToView:(UIView *)view andColor1:(UIColor *)color1 andColor2:(UIColor *)color2;
{
    [view setBackgroundColor:[UIColor clearColor]];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[color1 CGColor], (id)[color2 CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
}

+ (void)addFullResizeConstraints:(UIView *)subView addedOnParent:(UIView *)parent
{
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:subView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0
                                   constant:0.f];
    NSLayoutConstraint *bottom =[NSLayoutConstraint
                                 constraintWithItem:subView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:parent
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0
                                 constant:0.f];
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:subView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:parent
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0
                               constant:0.f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:subView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parent
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0
                                   constant:0.f];
    
    [parent addConstraint:trailing];
    [parent addConstraint:bottom];
    [parent addConstraint:top];
    [parent addConstraint:leading];
}

+ (void)addBlurToView:(UIView *)view
{
    view.backgroundColor = [UIColor clearColor];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addSubview:blurEffectView];
}

+ (void)bounceTargetView:(UIView *)targetView
{
    targetView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.3
          initialSpringVelocity:1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         targetView.transform = CGAffineTransformIdentity;
                     }
                     completion:nil];
}

+ (CGFloat)heightForString:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        return 0;
    }
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{ NSFontAttributeName : font };
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
    
    return size.height;
}

#pragma mark - UserDefaults crud -

+ (void)setUserDefaults:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getUserDefaultsForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (void)deleteUserDefaultsForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Global validations -

+ (BOOL)isOnline
{
//todo
//    [SCNetworkReachability host:@"github.com" reachabilityStatus:^(SCNetworkStatus status)
//    {
//        return status;
//    }];
    return true;
}

+ (BOOL)isURL:(NSString *)string {
    NSURL *candidateURL = [NSURL URLWithString:string];
    if (candidateURL && candidateURL.scheme && candidateURL.host) {
        return YES;
    }
    return NO;
}

+ (BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidContact:(NSString *)phoneNumber {
    phoneNumber = kStringAppend(@"+91", phoneNumber, @"");
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

+ (BOOL)isValidPincode:(NSString *)pincode {
    NSString *pinRegex = @"^[1-9][0-9]{5}$";
    NSPredicate *pinTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pinRegex];
    return [pinTest evaluateWithObject:pincode];
}

@end

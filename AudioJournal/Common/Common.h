//
//  Common.h
//  AudioJournal
//
//  Created by Bhishak Sanyal on 31/08/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kStringAppend(string1,string2,string3) [NSString stringWithFormat:@"%@%@%@",string1,string2,string3]

// Enums will go here


NS_ASSUME_NONNULL_BEGIN

@interface Common : NSObject

/**
 UI builder helper methods
 */

+ (void)createCircleWithView:(UIView *)view;

+ (void)addShadowToView:(UIView *)view;

+ (float)getCalculatedValueOfValue:(float)value calculated:(BOOL)calculated;

+ (void)addNavGradientToView:(UIView *)view andColor1:(UIColor *)color1 andColor2:(UIColor *)color2;

+ (void)addFullResizeConstraints:(UIView *)subView addedOnParent:(UIView *)parent;

+ (void)addBlurToView:(UIView *)view;

+ (void)bounceTargetView:(UIView *)targetView;

+ (CGFloat)heightForString:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 UserDefaults crud methods
 */

+ (void)setUserDefaults:(id)value forKey:(NSString *)key;

+ (id)getUserDefaultsForKey:(NSString *)key;

+ (void)deleteUserDefaultsForKey:(NSString *)key;

/**
 Validation methods
 */

+ (BOOL)isOnline;

+ (BOOL)isURL:(NSString*)string;

+ (BOOL)isValidEmail:(NSString *)email;

+ (BOOL)isValidContact:(NSString *)phoneNumber;

+ (BOOL)isValidPincode:(NSString *)pincode;

@end

NS_ASSUME_NONNULL_END

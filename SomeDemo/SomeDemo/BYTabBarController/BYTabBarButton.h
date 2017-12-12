//
//  BYTabBarButton.h
//  SomeDemo
//
//  Created by xindy on 2017/6/16.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BYTabBarButtonTypeDefault,
    BYTabBarButtonTypeMiddleWithTitle,
    BYTabBarButtonTypeMiddleNoTitle,
    
} BYTabBarButtonType;

@interface BYTabBarButton : UIButton


/**
 <#Description#>

 @param frame <#frame description#>
 @param type <#type description#>
 @param fontSize <#fontSize description#>
 @param height <#height description#>
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame butttonType:(BYTabBarButtonType)type titleLabelFontSize:(CGFloat)fontSize titleLabelHeight:(CGFloat)height;


@end

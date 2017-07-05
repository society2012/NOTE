//
//  UIView+ActivityIndicatorView.h
//  ZinTaoSellerAPP
//
//  Created by hupeng on 16/6/16.
//  Copyright © 2016年 cherrySmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ActivityIndicatorView)


/**
 @功能:在视图上添加HUD
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDActivityView:(NSString*) labelText;

/**
 @功能:删除视图上的HUD
 @返回值:空
 */
- (void) removeHUDActivityView;

    //带背景的文字提示
- (void) addHUDLabelView:(NSString*) labelText afterDelay:(NSTimeInterval)delay;

@end

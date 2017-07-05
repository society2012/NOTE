//
//  UIView+ActivityIndicatorView.m
//  ZinTaoSellerAPP
//
//  Created by hupeng on 16/6/16.
//  Copyright © 2016年 cherrySmart. All rights reserved.
//

#import "UIView+ActivityIndicatorView.h"
#import "MBProgressHUD.h"

@implementation UIView (ActivityIndicatorView)


/**
 @功能:在视图上添加HUD菊花
 @参数1:UIActivityIndicatorViewStyle  菊花类型
 @返回值:更改后的图片对象
 */
- (void) addHUDActivityView:(NSString*) labelText{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText =labelText;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.color =[[UIColor blackColor] colorWithAlphaComponent:0.7];
    
}

/**
 @功能:删除视图上的HUD菊花
 @返回值:空
 */
- (void) removeHUDActivityView{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

    //文字提示
- (void) addHUDLabelView:(NSString*) labelText afterDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.color =[UIColor blackColor];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = labelText;
    hud.color =[[UIColor blackColor] colorWithAlphaComponent:0.7];
    [hud hide:YES afterDelay:delay];
}


@end

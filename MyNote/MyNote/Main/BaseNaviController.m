//
//  BaseNaviController.m
//  MyNote
//
//  Created by hupeng on 2017/6/14.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "BaseNaviController.h"

@interface BaseNaviController ()<UINavigationControllerDelegate>

@end

@implementation BaseNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *naviBar =[UINavigationBar appearance];
    naviBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
   
}



-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
       if (self.viewControllers.count > 0) {
           UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -5;
            
            UIButton *button =[UIButton buttonWithType:0];
            button.frame = CGRectMake(0, 0, 20, 20);
            [button setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
            viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
                // 就有滑动返回功能
            self.interactivePopGestureRecognizer.delegate = nil;
        }
        [super pushViewController:viewController animated:animated];

}


-(void)backAction{
    [self popViewControllerAnimated:YES];
}

@end

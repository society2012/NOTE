//
//  BaseViewController.m
//  MyNote
//
//  Created by hupeng on 2017/6/15.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    if(self.navigationController.childViewControllers.count == 1){
//        [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//        [delegate.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//        
//    }else{
//        [delegate.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
//        [delegate.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
//    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

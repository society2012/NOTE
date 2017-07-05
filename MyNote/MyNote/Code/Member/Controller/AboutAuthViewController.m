//
//  AboutAuthViewController.m
//  MyNote
//
//  Created by hupeng on 2017/6/15.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "AboutAuthViewController.h"


@interface AboutAuthViewController ()

@end

@implementation AboutAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title = @"关于我";
    
    
    
    
    
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 564/2, 786/2)];
    imageView.image = [UIImage imageNamed:@"erweima.JPG"];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

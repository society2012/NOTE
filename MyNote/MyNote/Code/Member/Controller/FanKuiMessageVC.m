//
//  FanKuiMessageVC.m
//  cherrysmart
//
//  Created by User on 15/5/13.
//  Copyright (c) 2015年 qingxinhuyu. All rights reserved.
//

#import "FanKuiMessageVC.h"

@interface FanKuiMessageVC ()<UITextViewDelegate>

{
    UITextView *oneText;
}

@end

@implementation FanKuiMessageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor =[UIColor whiteColor];
    oneText =[[UITextView alloc] initWithFrame:CGRectMake(5, 10, ScreenW-10, 200)];
    [oneText becomeFirstResponder];
    oneText.font = [UIFont systemFontOfSize:14];
    oneText.delegate = self;
    oneText.backgroundColor =[UIColor clearColor];
    [self.view addSubview:oneText];
    [self initRightItem];
    
}


-(void)initRightItem{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    UIButton *button =[UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 60, 20);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:RGBVCOLOR(0x333333) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(overAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];
    
}


-(void)overAction:(UIButton *)button
{
    [oneText resignFirstResponder];
    if(oneText.text == nil ||oneText.text.length == 0){
        return;
    }
    [self netWorkRequest];
}

-(void)netWorkRequest{
    [self.view addHUDActivityView:@"反馈中"];
    NSString *urlStr = @"http://www.hubalala.cn/blog/index.php/api/AppInterface/kefuMessage";
    NSDictionary *parameters = @{@"content":oneText.text};
    AFHTTPSessionManager* manage = [AFHTTPSessionManager manager];
    manage.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manage.requestSerializer.timeoutInterval= 30;
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    [manage POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.view removeHUDActivityView];
        NSString *code = responseObject[@"code"];
        if([code integerValue] == 200){
            [self.view addHUDLabelView:@"反馈成功" afterDelay:1];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];

    return;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *oneTouch =[touches anyObject];
    if(oneTouch.tapCount == 1){
        [oneText resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

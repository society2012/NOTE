//
//  NoteDetailViewController.m
//  MyNote
//
//  Created by hupeng on 2017/6/14.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "NoteDetailViewController.h"
#import "UIView+ActivityIndicatorView.h"

@interface NoteDetailViewController ()<UIWebViewDelegate>

@end

@implementation NoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupWebView];
    
    
}

-(void)setupNavi{
    UIImageView *logoView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 123, 23)];
    logoView.image =[UIImage imageNamed:@"textLogo.jpg"];
    
    self.navigationItem.titleView =logoView;
}

-(void)setupWebView{
    UIWebView *webview =[[UIWebView alloc] initWithFrame:self.view.bounds];
    webview.delegate = self;
    NSString *str =[NSString stringWithFormat:@"http://www.hubalala.cn/blog/index.php/Home/Article/article/id/%@",self.noteId];
    NSURL *url =[NSURL URLWithString:str];
    NSURLRequest *req =[[NSURLRequest alloc] initWithURL:url];
    [webview loadRequest:req];
    [self.view addSubview:webview];
    
    self.view.backgroundColor =[UIColor whiteColor];

}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view addHUDActivityView:@"加载中"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view removeHUDActivityView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

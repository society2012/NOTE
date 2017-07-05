//
//  ViewController.m
//  MyNote
//
//  Created by hupeng on 2017/6/14.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "HomeViewController.h"


#import "MMDrawerController.h"
#import "AppDelegate.h"
#import "AboutAuthViewController.h"
#import "CateModel.h"
#import "SegmentView.h"

#import "CateDataController.h"
#import "SearchViewController.h"
#import "SetViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SegmentViewDelegate,UIScrollViewDelegate>{
    int page;
}

/* 滚动视图**/
@property(nonatomic, strong) UIScrollView *scrollView;


@property(nonatomic,strong)NSMutableArray *dataS;


@property(nonatomic,strong)SegmentView *segmengView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goNextVC:) name:@"leftMenuAction" object:nil];
    _dataS =[NSMutableArray array];
    [self initView];
    [self initLeftBtn];
    [self initRightItem];
  
    [self setupNavi];
    [self setupCateData];
}

-(void)initView{
    
    _segmengView =[SegmentView segmentView];
    _segmengView.delegate = self;
    [self.view addSubview:_segmengView];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, CGRectGetMaxY(_segmengView.frame), ScreenW, ScreenH - 35 - 64 );
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    
    
  
}

-(void)initLeftBtn{

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    
    UIButton *button =[UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 16, 16);
    [button setBackgroundImage:[UIImage imageNamed:@"mainSlide"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"mainSlide"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];


}


-(void)initRightItem{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -5;
    
    UIButton *button =[UIButton buttonWithType:0];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, backButton];

}

-(void)setupNavi{
    UIImageView *logoView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 123, 23)];
    logoView.image =[UIImage imageNamed:@"textLogo.jpg"];
    
    self.navigationItem.titleView =logoView;
}



-(void)searchAction:(UIButton *)btn{
    SearchViewController *searchVC =[[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)setupCateData{
//    [self.view addHUDActivityView:@"加载中"];
    NSString *urlStr = @"http://www.hubalala.cn/blog//index.php/api/AppInterface/getCatLst";
     AFHTTPSessionManager* manage = [AFHTTPSessionManager manager];
    manage.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manage.requestSerializer.timeoutInterval= 30;
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    [manage POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.view removeHUDActivityView];
        NSString *code = responseObject[@"code"];
        if([code integerValue] == 200){
            NSArray *datas= responseObject[@"data"];
            [self.dataS removeAllObjects];
            

 
            
            for (NSDictionary *dic in datas) {
                CateModel *model =[[CateModel alloc] init];
                model.cateId =dic[@"id"];
                model.cateName =dic[@"catename"];
                
                [self.dataS addObject:model];
                
                CateDataController*classifyVC = [[CateDataController alloc]init];
                classifyVC.cateId = model.cateId;
                [self addChildViewController:classifyVC];
                
            }
            
            
             _segmengView.titles = self.dataS;
            _scrollView.contentSize = CGSizeMake(self.dataS.count * ScreenW, _scrollView.frame.size.height);
            [self scrollViewDidEndScrollingAnimation:_scrollView];
           
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidEndScrollingAnimation");
    
    CGFloat offSet = scrollView.contentOffset.x;
    NSInteger index = offSet / ScreenW;
    
    
    [_segmengView moveLindeToIndex:index];
    
    CateModel *model =self.dataS[index];
    CateDataController *vc = self.childViewControllers[index];
    vc.cateId = model.cateId;
    vc.view.x = offSet;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    vc.view.width = scrollView.width;
    [scrollView addSubview:vc.view];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

-(void)menuAction{
    if(self.navigationController.childViewControllers.count<=1){
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        MMDrawerController *drawerController = delegate.drawerController;
        
        [drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }

}


-(void)goNextVC:(NSNotification *)note{
    NSIndexPath *path = (NSIndexPath *)note.object;
    if(path.row ==0 ){
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id1248749905"]];
    }
    if(path.row ==1){
        AboutAuthViewController *auth =[[AboutAuthViewController alloc] init];
        [self.navigationController pushViewController:auth animated:YES];
    }
    if(path.row ==2){
        SetViewController *setVC =[[SetViewController alloc] init];
         [self.navigationController pushViewController:setVC animated:YES];
    }
    
}



// MARK:-


-(void)clickSegmentBtn:(NSInteger)index{
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = index *ScreenW;
    
    [self.scrollView setContentOffset:offset animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

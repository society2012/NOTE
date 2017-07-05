//
//  CateDataController.m
//  MyNote
//
//  Created by hupeng on 2017/6/20.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "CateDataController.h"
#import "MyNoteCell.h"
#import "NoteDetailViewController.h"
#import "NoteModel.h"


@interface CateDataController ()<UITableViewDelegate,UITableViewDataSource>{
    int page;
}

@property(nonatomic,strong)NSMutableArray *datas;
@property (strong, nonatomic) IBOutlet UITableView *noteTable;


@end

@implementation CateDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    _datas =[NSMutableArray array];
    [self setupUI];
    [self initData];

    [self setupdata];
   
}


-(void)setupdata{
    
    [self.view addHUDActivityView:@"加载中"];
    NSString *urlStr = @"http://www.hubalala.cn/blog/index.php/api/AppInterface/getCatArticle";
    NSDictionary *parameters = @{@"page":[NSNumber numberWithInt:page],@"pagesize":@"10",@"id":self.cateId};
    AFHTTPSessionManager* manage = [AFHTTPSessionManager manager];
    manage.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manage.requestSerializer.timeoutInterval= 30;
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    [manage POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.view removeHUDActivityView];
        NSString *code = responseObject[@"code"];
        if([code integerValue] == 200){
            [self.noteTable.mj_header endRefreshing];
            [self.noteTable.mj_footer endRefreshing];
            if(page==1){
                [self.datas removeAllObjects];
            }
            
            NSArray *datas= responseObject[@"data"];
            for (NSDictionary *dic in datas) {
                NoteModel *model =[[NoteModel alloc] init];
                model.title =dic[@"title"];
                model.desc =dic[@"desc"];
                model.noteId =dic[@"id"];
                model.pic =dic[@"pic"];
                [self.datas addObject:model];
            }
            [self.noteTable reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];
}


-(void)setupUI{

    UITableView *theTable =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64-35)];
    theTable.delegate = self;
    theTable.dataSource = self;
    theTable.tableFooterView =[[UIView alloc] init];
    [self.view addSubview:theTable];
    if ([theTable respondsToSelector:@selector(setSeparatorInset:)]){
        [theTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([theTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [theTable setLayoutMargins:UIEdgeInsetsZero];
    }
    self.noteTable = theTable;

}


-(void)initData{
    page = 1;
    _datas =[NSMutableArray array];
    self.noteTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.noteTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify =@"identify";
    MyNoteCell *cell =[tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell =[[[NSBundle mainBundle] loadNibNamed:@"MyNoteCell" owner:self options:nil] lastObject];
    }
    NoteModel *mode =self.datas[indexPath.row];
    cell.model = mode;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NoteModel *mode =self.datas[indexPath.row];
    NoteDetailViewController *detaiVC =[[NoteDetailViewController alloc] init];
    detaiVC.noteId = mode.noteId;
    [self.navigationController pushViewController:detaiVC animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{ // 去除 分割线前面的空白
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


    // MARK:-刷新

-(void)loadNewData{
    page = 1;
    [self setupdata];
}

-(void)loadMoreData{
    page++;
    [self setupdata];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

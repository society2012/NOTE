//
//  SearchViewController.m
//  MyNote
//
//  Created by hupeng on 2017/6/20.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "SearchViewController.h"
#import "MyNoteCell.h"
#import "CateModel.h"
#import "NoteDetailViewController.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *datas;
@property (strong, nonatomic) UITableView *noteTable;
@property(nonatomic,strong)UITextField *inputFild;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    _datas =[NSMutableArray array];
    [self setupSearchView];
    [self setupTable];
    
}


-(void)setupTable{
    UITableView *theTable =[[UITableView alloc] initWithFrame:self.view.bounds];
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




-(void)setupSearchView{

    
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW-100, 30)];
    view.userInteractionEnabled = YES;
    
    UIImageView *bgView =[[UIImageView alloc] initWithFrame:view.bounds];
    bgView.userInteractionEnabled = YES;
    UIImage *bgImage = [UIImage imageNamed:@"search.png"];
    UIEdgeInsets insert = UIEdgeInsetsMake(5, 35, 5, 10);
    bgImage =[bgImage resizableImageWithCapInsets:insert];
    bgView.image = bgImage;
    [view addSubview:bgView];
    
    
    UITextField * inputFild = [[UITextField alloc] initWithFrame:CGRectMake(30, 4, bgView.width-35, 22)];
    inputFild.font = [UIFont systemFontOfSize:13];
    inputFild.returnKeyType=UIReturnKeySearch;
    [inputFild setValue:RGBVCOLOR(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    inputFild.enablesReturnKeyAutomatically = YES;
    inputFild.backgroundColor =[UIColor clearColor];
    [inputFild becomeFirstResponder];
    inputFild.delegate = self;
    inputFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputFild.placeholder = @"请输入搜索的内容";
    [bgView addSubview:inputFild];
    
    self.inputFild = inputFild;
    
    [self.navigationItem setTitleView:view];
    

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


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.inputFild resignFirstResponder];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *key = textField.text;
    [textField resignFirstResponder];
    [self searchBlog:key];
    return YES;
}


-(void)searchBlog:(NSString *)key{

    [self.view addHUDActivityView:@"加载中"];
    NSString *urlStr = @"http://www.hubalala.cn/blog/index.php/api/AppInterface/searchArticle";
    NSDictionary *parameters = @{@"key":key};
    AFHTTPSessionManager* manage = [AFHTTPSessionManager manager];
    manage.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manage.requestSerializer.timeoutInterval= 30;
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
    [manage POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.view removeHUDActivityView];
        NSString *code = responseObject[@"code"];
        [self.datas removeAllObjects];
        if([code integerValue] == 200){
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

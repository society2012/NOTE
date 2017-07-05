//
//  LeftViewController.m
//  MyNote
//
//  Created by hupeng on 2017/6/15.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"

@interface LeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initTable];
    
}


-(void)initTable{
    UITableView *theTable =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenW*4/5, ScreenH-64)];
    theTable.delegate = self;
    theTable.dataSource = self;
    theTable.tableFooterView =[[UIView alloc] init];
    [self.view addSubview:theTable];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify =@"identify";
    LeftMenuCell *cell =[tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell =[[[NSBundle mainBundle] loadNibNamed:@"LeftMenuCell" owner:self options:nil] lastObject];
    }
    NSString *title = @"笔记";
    NSString *imageName = @"aboutMe.png";
    switch (indexPath.row) {
        case 0:
        {
            title = @"给个好评";
           imageName = @"startMe.png";
        }
            break;
        case 1:
        {
             title = @"关于作者";
        
         imageName = @"aboutMe.png";
        }
            break;
        case 2:
        {
            title = @"设置";
            imageName = @"setting.png";
        }
            break;

            
            
        default:
            break;
    }
    cell.nameLabel.text = title;
    cell.iconImage.image = [UIImage imageNamed:imageName];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MMDrawerController *drawerController = delegate.drawerController;
    
    [drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"leftMenuAction" object:indexPath];

    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{ // 去除 分割线前面的空白

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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

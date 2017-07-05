//
//  SetViewController.m
//  MyNote
//
//  Created by hupeng on 2017/6/20.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "SetViewController.h"
#import "FanKuiMessageVC.h"
#import "SDImageCache.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
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

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify =@"identify";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = RGBVCOLOR(0x333333);
    if(indexPath.row == 0){
        cell.textLabel.text = @"意见反馈";
    }
    if(indexPath.row == 2){
        cell.textLabel.text = @"联系我";
    }

    if(indexPath.row == 1){
       cell.textLabel.text = @"清理缓存";
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row ==0){
        FanKuiMessageVC *message =[[FanKuiMessageVC alloc] init];
        [self.navigationController pushViewController:message animated:YES];
    }
    if(indexPath.row ==1){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"你确定清理缓存吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        sheet.tag = 10;
        [sheet showInView:self.view];
    }
    if(indexPath.row == 2){
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"确认拨打作者电话吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex !=alertView.cancelButtonIndex){
        NSURL* telUrl=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4008-018-286"]];
        [[UIApplication sharedApplication]openURL:telUrl];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if(actionSheet.tag != actionSheet.cancelButtonIndex){
        [self.view addHUDActivityView:@"清理中"];
        [self performSelector:@selector(cleanCache) withObject:nil afterDelay:1.5];
        
        
    }

}

-(void)cleanCache{
    
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [self.view removeHUDActivityView];
    
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

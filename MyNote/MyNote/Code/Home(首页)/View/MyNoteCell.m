//
//  MyNoteCell.m
//  MyNote
//
//  Created by hupeng on 2017/6/14.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "MyNoteCell.h"

@interface MyNoteCell ()
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation MyNoteCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(NoteModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
//    NSString *str = @"http://www.hubalala.cn/blog/Public/Uploads2017-06-08/593926cca9730.jpg";
    
    NSString *pic = [NSString stringWithFormat:@"http://www.hubalala.cn/blog%@",model.pic];
    
    [self.pic sd_setImageWithURL:[NSURL URLWithString:pic]];
}


@end

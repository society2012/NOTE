//
//  MyNoteCell.h
//  MyNote
//
//  Created by hupeng on 2017/6/14.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyNoteCell : UITableViewCell

@property(nonatomic,strong)NoteModel *model;

@end

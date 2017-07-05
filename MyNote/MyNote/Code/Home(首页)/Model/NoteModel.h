//
//  NoteModel.h
//  MyNote
//
//  Created by hupeng on 2017/6/14.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSNumber *noteId;
@property(nonatomic,strong)NSString *pic;

@end

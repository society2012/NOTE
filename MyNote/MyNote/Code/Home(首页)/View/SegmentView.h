//
//  SegmentView.h
//  MyNote
//
//  Created by hupeng on 2017/6/20.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateModel.h"

@protocol SegmentViewDelegate <NSObject>

-(void)clickSegmentBtn:(NSInteger)index;

@end

@interface SegmentView : UIView

@property(nonatomic,strong)NSMutableArray *titles;

@property(nonatomic,assign)id<SegmentViewDelegate>delegate;

+(instancetype)segmentView;

-(void)moveLindeToIndex:(NSInteger)index;

@end

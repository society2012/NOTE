//
//  SegmentView.m
//  MyNote
//
//  Created by hupeng on 2017/6/20.
//  Copyright © 2017年 m.zintao. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentView ()

@property(nonatomic,strong)UIScrollView *bgScroView;

@property(nonatomic,strong)NSMutableArray *buttons;

@property(nonatomic,strong)UIView *bottonView;

@end

@implementation SegmentView


-(NSMutableArray *)buttons{
    if(!_buttons){
        _buttons =[NSMutableArray array];
    }
    return _buttons;
}

-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if(self){
        _bgScroView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, self.bounds.size.height-1)];
        _bgScroView.showsHorizontalScrollIndicator = NO;
        _bgScroView.backgroundColor =[UIColor whiteColor];
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, ScreenW, 0.5)];
        line.backgroundColor = RGBVCOLOR(0x999999);
        [self addSubview:line];
        [self addSubview:_bgScroView];
        
        
        _bottonView =[[UIView alloc] initWithFrame:CGRectMake(10, 33, 60, 2)];
        _bottonView.backgroundColor =[UIColor redColor];
        [_bgScroView addSubview:_bottonView];
        self.backgroundColor = RGBVCOLOR(0xf2f4f7);
    }
    return self;
    
}


+(instancetype)segmentView{
    return [[self alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 35)];
}

-(void)setTitles:(NSMutableArray *)titles{
    _titles = titles;
    [self.buttons removeAllObjects];
    int i=0;
    for (CateModel *cate in titles) {
        UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(80*i, 0, 80, self.bounds.size.height-1)];
        btn.tag = i;
        [btn setTitle:cate.cateName forState:UIControlStateNormal];
        [self.bgScroView addSubview:btn];
        [btn setTitleColor:RGBVCOLOR(0x999999) forState:
         UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        [self.buttons addObject:btn];
    }
    
    _bgScroView.contentSize = CGSizeMake(self.titles.count*80, self.bounds.size.height-1);
    
}


-(void)clickBtn:(UIButton *)btn{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickSegmentBtn:)]){
        [self.delegate clickSegmentBtn:btn.tag];
    }
    
    
    [self moveLindeToIndex:btn.tag];
}



-(void)moveLindeToIndex:(NSInteger)index{
    
    UIButton *btn = self.buttons[index];
    
    if(btn.centerX >_bgScroView.centerX){
        
        CGFloat offSet = btn.centerX - self.width/2;
        if(offSet<0){
            offSet=0;
        }
        CGFloat maxOffSet = _bgScroView.contentSize.width - self.width;
        if (offSet > maxOffSet) {
            offSet = maxOffSet;
        }
        
        [_bgScroView setContentOffset:CGPointMake(offSet, 0) animated:YES];
        
        
    }

    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bottonView.center = CGPointMake(btn.center.x,  self.bottonView.center.y);
    } completion:^(BOOL finished) {
        
    }];

}

@end

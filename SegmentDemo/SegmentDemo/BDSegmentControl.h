//
//  SegmentView.h
//  SegmentDemo
//
//  Created by 冰点 on 15/4/22.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

/*
 使用:
 #import "BDSegmentControl.h"
 - (void) initSegmentView
 {
 
 BDSegmentControl * segment = [[BDSegmentControl alloc] initWithFrame:CGRectMake(15, 0, SCR_Width-30, 30) items:@[@"优越", @"幽月"]];
 segment.tintColor = [UIColor redColor];
 segment.delegate = self;
 self.navigationItem.titleView = segment;
 }

 */


#import <UIKit/UIKit.h>

@protocol BDSegmentViewDelegate <NSObject>
@optional
/**
 *  item的点击事件
 *
 *  @param index item的索引
 */
- (void) didSegmentViewSelectIndex: (NSInteger) index;

@end

@interface BDSegmentControl : UIView

/**
 *  设置风格颜色 默认是蓝色
 */
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, assign) id <BDSegmentViewDelegate> delegate;

/**
 *  构造函数
 *
 *  @param frame frame
 *  @param items title字符串数据
 *
 *  @return 当前实例
 */
- (instancetype)initWithFrame : (CGRect)frame items: (NSArray*) items;
@end

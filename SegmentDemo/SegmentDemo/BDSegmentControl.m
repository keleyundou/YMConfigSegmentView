//
//  SegmentView.m
//  SegmentDemo
//
//  Created by 冰点 on 15/4/22.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import "BDSegmentControl.h"

#define RGB_Color(r,g,b)    RGBA_Color(r,g,b,1)
#define RGBA_Color(r,g,b,a) ([UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:a])
#define kDefaultTintColor   RGB_Color(3, 116, 255)
#define kLeftMargin         15
#define kItemHeight         30
#define kBorderLineWidth    0.5
#define kTitleFont          14

@class BDSegmentItem;
@protocol BDSegmentItemDelegate <NSObject>

- (void) itemStateChanged: (BDSegmentItem*) currentItem
                    index: (NSInteger) index
               isSelected: (BOOL) isSelected;

@end

@interface BDSegmentItem : UIView
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) id <BDSegmentItemDelegate> delegate;
@end

@implementation BDSegmentItem

- (instancetype)initWithFrame: (CGRect) frame
                        index: (NSInteger) index
                        title: (NSString*) title
                  normalColor: (UIColor*) normalColor
                  selectColor: (UIColor*) selectColor
                   isSelected: (BOOL) isSelected
{
    self = [super initWithFrame:frame];
    if (self) {
        //init code...
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:kTitleFont];
        [self addSubview:_titleLabel];
        
        self.normalColor = normalColor;
        self.selectColor = selectColor;
        self.titleLabel.text = title;
        self.index = index;
        self.isSelected = isSelected;
    }
    return self;
}

- (void)setSelectColor:(UIColor *)selectColor
{
    if (_selectColor != selectColor) {
        _selectColor = selectColor;
        if (_isSelected) {
            self.titleLabel.textColor = self.normalColor;
            self.backgroundColor = self.selectColor;
        }
        else
        {
            self.titleLabel.textColor = self.selectColor;
            self.backgroundColor = self.normalColor;
        }
    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected) {
        self.titleLabel.textColor = self.normalColor;
        self.backgroundColor = self.selectColor;
    }
    else
    {
        self.titleLabel.textColor = self.selectColor;
        self.backgroundColor = self.normalColor;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isSelected = !_isSelected;
    if ([self.delegate respondsToSelector:@selector(itemStateChanged:index:isSelected:)]) {
        [self.delegate itemStateChanged:self index:self.index isSelected:self.isSelected];
    }
}
@end

@interface BDSegmentControl () <BDSegmentItemDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableArray * titlesArray;
@property (nonatomic, strong) NSMutableArray * itemsArray;
@property (nonatomic, strong) NSMutableArray * linesArray;
@end
@implementation BDSegmentControl

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        //init code...
        self.backgroundColor = [UIColor clearColor];
        float viewWidth = CGRectGetWidth(frame);
        float viewHeight = CGRectGetHeight(frame);
        float initX = CGRectGetMinX(frame);
        float initY = CGRectGetMinY(frame);
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(kLeftMargin, (viewHeight-kItemHeight)/2, viewWidth-2*kLeftMargin, kItemHeight)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.bgView.clipsToBounds = YES;
        self.bgView.layer.cornerRadius = kItemHeight/2;
        self.bgView.layer.borderWidth = kBorderLineWidth;
        self.bgView.layer.borderColor = kDefaultTintColor.CGColor;
        [self addSubview:self.bgView];
        
        initX = 0; initY = 0;
        
        float itemWidth = CGRectGetWidth(self.bgView.frame)/items.count;
        float itemHeight = CGRectGetHeight(self.bgView.frame);
        
        if (items.count >= 2) {
            for (NSInteger i = 0; i < [items count]; i++) {
                BDSegmentItem * item = [[BDSegmentItem alloc] initWithFrame:CGRectMake(initX, initY, itemWidth, itemHeight)
                                                                      index:i
                                                                      title:items[i]
                                                                normalColor:[UIColor whiteColor]
                                                                selectColor:kDefaultTintColor
                                                                 isSelected:(i == 0)? YES: NO];
                initX += itemWidth;
                [self.bgView addSubview:item];
                item.delegate = self;
                
                //save all items
                if (!self.itemsArray) {
                    self.itemsArray = [NSMutableArray arrayWithCapacity:items.count];
                }
                [self.itemsArray addObject:item];
            }
            
            //add all lines
            initX = 0;
            for (NSInteger i = 0; i < [items count]; i++) {
                initX += itemWidth;
                UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(initX, 0, kBorderLineWidth, itemHeight)];
                lineView.backgroundColor = kDefaultTintColor;
                [self.bgView addSubview:lineView];
                
                //save all lines
                if (!self.linesArray) {
                    self.linesArray = [NSMutableArray arrayWithCapacity:items.count];
                }
                [self.linesArray addObject:lineView];
            }
        }
        else
        {
            NSException *exc = [[NSException alloc] initWithName:@"items count error"
                                                          reason:@"items count at least 2"
                                                        userInfo:nil];
            @throw exc;
        }
    }
    return self;
}

- (void)setTintColor:(UIColor *)tintColor
{
    if ([self.itemsArray count] < 2) {return;}
    
    if (_tintColor != tintColor) {
        self.bgView.layer.borderColor = tintColor.CGColor;
        for (NSInteger i = 0; i<self.itemsArray.count; i++) {
            BDSegmentItem *item = self.itemsArray[i];
            item.selectColor = tintColor;
            [item setNeedsDisplay];
        }
        
        for (NSInteger i = 0; i<self.linesArray.count; i++) {
            UIView *lineView = self.linesArray[i];
            lineView.backgroundColor = tintColor;
        }
    }
}

//MARK:BDSegmentItemDelegate
- (void)itemStateChanged:(BDSegmentItem *)currentItem index:(NSInteger)index isSelected:(BOOL)isSelected
{
    if ([self.itemsArray count] < 2) {return;}
    for (NSInteger i = 0; i < self.itemsArray.count; i++) {
        BDSegmentItem * item = self.itemsArray[i];
        item.isSelected = NO;
    }
    currentItem.isSelected = YES;
    if ([self.delegate respondsToSelector:@selector(didSegmentViewSelectIndex:)]) {
        [self.delegate didSegmentViewSelectIndex:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

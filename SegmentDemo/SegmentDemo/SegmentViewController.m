//
//  SegmentViewController.m
//  SegmentDemo
//
//  Created by 冰点 on 15/4/22.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import "SegmentViewController.h"

#import "BDSegmentControl.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface SegmentViewController ()<BDSegmentViewDelegate>

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.toolbarHidden = NO;
    
    [self initSegmentView];
    ViewController1 * controler1 = [[ViewController1 alloc] init];
    ViewController2 * controler2 = [[ViewController2 alloc] init];
    self.viewControllers = @[controler1, controler2];
    
    // Do any additional setup after loading the view.
}
- (void) initSegmentView
{
    //习惯与Tabbar结合使用--
    BDSegmentControl * segment = [[BDSegmentControl alloc] initWithFrame:CGRectMake(15, 0, SCR_Width-30, 30) items:@[@"优越", @"幽月"]];
    segment.tintColor = [UIColor redColor];
    segment.delegate = self;
    self.navigationItem.titleView = segment;
    //    [self.view addSubview:segment];
}
- (void)didSegmentViewSelectIndex:(NSInteger)index
{
    self.selectedIndex = index;
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

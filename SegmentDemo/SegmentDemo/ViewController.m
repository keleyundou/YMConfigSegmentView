//
//  ViewController.m
//  SegmentDemo
//
//  Created by 冰点 on 15/4/22.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import "ViewController.h"
#import "SegmentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //130 260
//    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:@[@"左", @"右"]];
//    segment.frame = CGRectMake(15, 30, SCR_Width-30, 30);
////    [segment setImage:[UIImage imageNamed:@"用户端-2.1.1.1项目收藏_03"] forSegmentAtIndex:0];
//    segment.tintColor = [UIColor whiteColor];
////    segment.backgroundColor = [UIColor purpleColor];
//    segment.selectedSegmentIndex = 0;
//    segment.layer.cornerRadius = 15;
//    segment.layer.masksToBounds = YES;
//    [self.view addSubview:segment];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SegmentViewController * controler = [[SegmentViewController alloc] init];
    controler.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controler animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

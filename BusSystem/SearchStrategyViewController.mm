//
//  SearchStrategyViewController.m
//  BusSystem
//
//  Created by 董思言 on 15/4/3.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#import "SearchStrategyViewController.h"

@interface SearchStrategyViewController ()
@property (weak, nonatomic) IBOutlet UIButton *costButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *realButton;

@end

@implementation SearchStrategyViewController
@synthesize costButton, timeButton, realButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    costButton.layer.cornerRadius = 10;
    timeButton.layer.cornerRadius = 10;
    realButton.layer.cornerRadius = 10;
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

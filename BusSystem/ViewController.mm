//
//  ViewController.m
//  BusSystem
//
//  Created by 董思言 on 15/4/3.
//  Copyright (c) 2015年 董思言. All rights reserved.
//



#import "ViewController.h"
#include <fstream>
//#import <string.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *listButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation ViewController
@synthesize listButton, addButton, searchButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"mainViewDidLoad");
    listButton.layer.cornerRadius = 9;
    addButton.layer.cornerRadius = 9;
    searchButton.layer.cornerRadius = 9;


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

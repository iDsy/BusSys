//
//  AddViewController.m
//  BusSystem
//
//  Created by 董思言 on 15/4/12.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#import "AddViewController.h"
#import "BL.h"
#include "BusLine.h"
#include <iostream>

@interface AddViewController (){
    char station[17];
    int staCount;
    char numberInput;
    BusLine bls[100];
    int theNumberOfBL;
    BusLine blToAdd;
    BL *ocblToAdd;
    NSMutableArray* ocbls;
    int choose;
}



@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    choose = 0;
    //初始化车站对应编号
    staCount = 16;
    station[0] = '0';
    station[1] = 'A';
    station[2] = 'B';
    station[3] = 'C';
    station[4] = 'D';
    station[5] = 'E';
    station[6] = 'F';
    station[7] = 'G';
    station[8] = 'H';
    station[9] = 'I';
    station[10] = 'J';
    station[11] = 'K';
    station[12] = 'L';
    station[13] = 'M';
    station[14] = 'N';
    station[15] = 'O';
    station[16] = 'P';
    //初始化ui
    _textField.delegate = self;
    _mainLabel.text = @"线路名";
    _cancelButton.layer.cornerRadius = 3;
    _OKButton.layer.cornerRadius = 6;
    _finishButton.layer.cornerRadius = 9;
    //初始化blToAdd
    blToAdd = BusLine();
    
    //数据导入数组
    NSUserDefaults* infb = [NSUserDefaults standardUserDefaults];
    ocbls = [[NSMutableArray alloc]initWithArray:[infb objectForKey:@"ocbls"]];
    if (ocbls.count == 0) {
        NSLog(@"初始时没数据");
    }else{
        NSLog(@"初始时%d条数据", ocbls.count);
        for (int i=0; i<ocbls.count; i++) {
            BL* blOutFromArray = [NSKeyedUnarchiver unarchiveObjectWithData: [ocbls objectAtIndex:i]];
            BusLine blFromBL = [blOutFromArray getBusLine];
            bls[theNumberOfBL] = blFromBL;
            theNumberOfBL++;
        }
    }
     
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * action
 */
- (IBAction)cancelButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)returnKeyboard:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)backgroundButtonClicked:(id)sender {
    [_textField resignFirstResponder];
}

- (IBAction)OKButtonClicked:(id)sender {
    switch (choose) {
        //线路名
        case 0:{
            numberInput = *[_textField.text UTF8String];
            cout<<"numberInput="<<numberInput<<"."<<endl;
            BOOL exist = NO;
            for (int i=0; i<theNumberOfBL; i++) {
                if(numberInput == int(bls[i].number)){
                    exist = YES;
                    break;
                }
            }
            if(!exist){
                blToAdd.number = numberInput;
                cout<<"blToAdd.number="<<blToAdd.number<<"."<<endl;
                _mainLabel.text = @"车站名（0结束）";
                _textField.text = NULL;
                choose++;
            }else{
                UIAlertView* alt = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"线路号已存在" otherButtonTitles:nil, nil];
                [alt show];
                numberInput = 0;
            }
            return;
        }
        //车站名
        case 1:{
            if ([_textField.text isEqual: @"0"]) {
                _mainLabel.text = @"价格";
                _textField.text = NULL;
                choose++;
            }else{
                blToAdd.sta[blToAdd.count] = *[_textField.text UTF8String];
                blToAdd.count++;
                /* 写入数组sta并没有问题
                cout<<"此时count为"<<blToAdd.count<<endl;
                for(int i=0; i<blToAdd.count; i++){
                    cout<<"此时sta["<<i<<"]为"<<blToAdd.sta[i]<<endl;
                }
                 */
                _textField.text = NULL;
            }
            return;
        }
        //价格
        case 2:{
            blToAdd.price = *[_textField.text UTF8String];
            _mainLabel.text = @"间隔时间";
            _textField.text = NULL;
            choose++;
            //cout<<"blToAdd.price为"<<blToAdd.price<<"."<<endl;
            return;
        }
        //间隔
        case 3:{
            blToAdd.interval = *[_textField.text UTF8String];
            _mainLabel.text = @"速度";
            _textField.text = NULL;
            choose++;
            //NSLog(@"OCBLinterval为%d", blToAdd.interval);
            return;
        }
        //速度
        case 4:{
            blToAdd.speed = *[_textField.text UTF8String];
            _mainLabel.text = @"点击完成添加";
            _textField.text = @"完成";
            choose++;
            return;
        }
        
    }
}
- (IBAction)finishButtonClicked:(id)sender {
    if ([_mainLabel.text isEqual:@"点击完成添加"]) {
        
        //cout<<"finishButtonClicked:blToAdd.number="<<blToAdd.count<<"."<<endl;

        ocblToAdd = [[BL alloc]init:blToAdd];
        
        /*
        for (int i=0; i<ocblToAdd.sta.count; i++) {
            NSLog(@"%@", ocblToAdd.sta[i]);
        }
        NSLog(@"最终ocblToAdd为%@", ocblToAdd.count);
         */
        
        
        
        
        [ocbls addObject:[NSKeyedArchiver archivedDataWithRootObject:ocblToAdd]];
        
        
        
        NSUserDefaults* outfb = [NSUserDefaults standardUserDefaults];
        [outfb setObject:ocbls forKey:@"ocbls"];
        
        
        /*
        //test
        NSArray* testArray = [outfb objectForKey:@"ocbls"];
        BL* blTest = [NSKeyedUnarchiver unarchiveObjectWithData:testArray[testArray.count-1]];
        for (int i=0; i<blTest.sta.count; i++) {
            NSLog(@"%@", blTest.sta[i]);
        }
        NSLog(@"最终ocblToAdd为%@", blTest.count);
        */
        
        
        
        
        UIAlertView* alt = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"添加成功" otherButtonTitles:nil, nil];
        [alt show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"请输入完整信息" otherButtonTitles:nil, nil];
        [alt show];
    }
}









@end

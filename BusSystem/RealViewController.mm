//
//  RealViewController.m
//  BusSystem
//
//  Created by 董思言 on 15/4/20.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#import "RealViewController.h"
#import "Matrix.h"
#import "BusLine.h"
#import "BL.h"
#include <iostream>
using namespace std;
@interface RealViewController (){
    Matrix mtx;
    char station[17];
    int staCount, stnb1, stnb2;
    BusLine bls[100];
    int theNumberOfBL;
    int p[100];
    int d[100];
}
@property (weak, nonatomic) IBOutlet UITextField *startTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation RealViewController
@synthesize startTextField, endTextField, searchButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化车站数 编号
    staCount = 16;
    stnb1 = 0;
    stnb2 = 0;
    //初始化车站对应编号
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
    //初始化矩阵
    mtx = Matrix(staCount);
    //初始化 d p
    for(int i=0; i<100; i++) {
        d[i] = 0;
        p[i] = 0;
    }
    //初始化bl元素数
    theNumberOfBL = 0;
    //初始化UI
    searchButton.layer.cornerRadius = 9;
    
    //数据导入数组
    NSUserDefaults* infb = [NSUserDefaults standardUserDefaults];
    NSMutableArray* ocbls = [[NSMutableArray alloc]initWithArray:[infb objectForKey:@"ocbls"]];
    for (int i=0; i<ocbls.count; i++) {
        //cout<<i<<endl;
        BL* blOutFromArray = [NSKeyedUnarchiver unarchiveObjectWithData: [ocbls objectAtIndex:i]];
        BusLine blFromBL = [blOutFromArray getBusLine];
        bls[theNumberOfBL] = blFromBL;
        theNumberOfBL++;
    }
    NSLog(@"已有车次数：%d", theNumberOfBL);
    //数组导入矩阵
    for (int pos=0; pos<theNumberOfBL; pos++) {
        for (int i=0; i<bls[pos].count; i++) {
            for (int j=1; j<=staCount; j++) {
                if (bls[pos].sta[i]==station[j]) {
                    stnb1 = j;
                }
                if (bls[pos].sta[i+1]==station[j]) {
                    stnb2 = j;
                }
            }
            mtx.Add(stnb1, stnb2, bls[pos].speed, bls[pos].number, bls[pos].interval);
            stnb1 = stnb2 = 0;
        }
        
        
    }

}
/*
 * action
 */
- (IBAction)backgroundButtonClicked:(id)sender {
    [startTextField resignFirstResponder];
    [endTextField resignFirstResponder];
}
- (IBAction)startTextFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)endTextFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)searchButtonClicked:(id)sender {
    
    /*
     * 待做
     */
    char sta1, sta2;
    //匹配线路
    sta1 = *[startTextField.text UTF8String];
    sta2 = *[endTextField.text UTF8String];
    //根据车站名称找到车站对应编号
    for (int i=1; i<=staCount; i++) {
        if (sta1==station[i]) {
            stnb1 = i;
            //cout<<"始发车站编号"<<stnb1<<endl;
        }
        if (sta2==station[i]) {
            stnb2 = i;
            //cout<<"终点车站编号"<<stnb2<<endl;
        }
    }
    if (stnb1==0 || stnb2==0) {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"输入有误" otherButtonTitles:nil, nil];
        [alt show];
        stnb1 = stnb2 = 0;
    }else{
        stack<int> s;
        bool b[100];
        for (int i=0; i<100; i++) {
            b[i] = false;
        }
        int min = 1000;
        string path;
        mtx.RealPaths(stnb1, stnb2, s, b, min, path);
        //cout<<"最终"<<path<<endl;
        // alt
        NSString* altMsg = [NSString stringWithUTF8String:path.c_str()];
        UIAlertView* alt = [[UIAlertView alloc]initWithTitle:nil message:altMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alt show];
    }
    
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

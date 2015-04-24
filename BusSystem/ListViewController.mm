//
//  ListViewController.m
//  BusSystem
//
//  Created by 董思言 on 15/4/12.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#import "ListViewController.h"
#import "BL.h"
#include "BusLine.h"
#include <iostream>
@interface ListViewController (){
    BusLine bls[100];
    int theNumberOfBL;
    NSMutableArray* ocbls;//nsdata类型
}
@property (weak, nonatomic) IBOutlet UITableView *listTableView;




@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"listViewDidLoad");
    //初始化ui
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    //数据导入数组
    NSUserDefaults* infb = [NSUserDefaults standardUserDefaults];
    ocbls = [[NSMutableArray alloc]initWithArray:[infb objectForKey:@"ocbls"]];
    if (ocbls.count == 0) {
        //NSLog(@"初始时没数据");
    }else{
        //NSLog(@"初始时%d条数据", ocbls.count);
        for (int i=0; i<ocbls.count; i++) {
            BL* blOutFromArray = [NSKeyedUnarchiver unarchiveObjectWithData: [ocbls objectAtIndex:i]];
            //NSLog(@"blOutFromArray的sta1为%@", blOutFromArray.sta[0]);
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
 * tableview
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return theNumberOfBL;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nameCell"];
    }
    //number
    char numberA[2];
    numberA[0] = bls[indexPath.row].number;
    numberA[1] = '\0';
    NSString* numberToPass = [[NSString alloc]initWithUTF8String:numberA];
    
    //sta
    NSString* staToPass = @" ";
    for (int i=0; i<bls[indexPath.row].count; i++) {
        char staA[2];
        staA[0] = bls[indexPath.row].sta[i];
        staA[1] = '\0';
        NSString* staTemp = [[NSString alloc]initWithUTF8String:staA];
        if (i==0) {
            
        }else{
            staToPass = [staToPass stringByAppendingString:@" "];
        }
        staToPass = [staToPass stringByAppendingString:staTemp];
        cout<<endl<<endl;
    }
    //NSLog(@"%@", staToPass);
    
    //price
    char priceA[2];
    priceA[0] = bls[indexPath.row].price;
    priceA[1] = '\0';
    NSString* priceToPass = [[NSString alloc]initWithUTF8String:priceA];
    //interval
    char intervalA[2];
    intervalA[0] = bls[indexPath.row].interval;
    intervalA[1] = '\0';
    NSString* intervalToPass = [[NSString alloc]initWithUTF8String:intervalA];
    //speed
    char speedA[2];
    speedA[0] = bls[indexPath.row].speed;
    speedA[1] = '\0';
    NSString* speedToPass = [[NSString alloc]initWithUTF8String:speedA];
    
    // cell textlabel text
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.text = [[NSString alloc]initWithFormat:@" No. %@\n 途径车站:%@\n 价格¥%@   间隔%@s   速度%@m/s", numberToPass, staToPass, priceToPass, intervalToPass, speedToPass];
    
    return cell;
}

//tableview滑动
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除nsuserdefault中对应部分
    [ocbls removeObjectAtIndex:indexPath.row];
    NSUserDefaults* outf = [NSUserDefaults standardUserDefaults];
    NSArray* arrayPass = ocbls;
    [outf setValue:arrayPass forKey:@"ocbls"];
    //删除bls数组中对应部分
    for (int i=indexPath.row; i<theNumberOfBL-1; i++) {
        bls[i] = bls[i+1];
    }
    theNumberOfBL--;
    [tableView reloadData];
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

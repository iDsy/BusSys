//
//  BusLine.h
//  BusSystem
//
//  Created by 董思言 on 15/4/3.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#ifndef __BusSystem__BusLine__
#define __BusSystem__BusLine__

#include <stdio.h>
#include <string>
using namespace std;

class BusLine{
public:
    char number, sta[100], price, interval, speed;
    int count=0;
    //数据顺序：路线号 车站名称 价格 间隔 速度
    BusLine(){
        number = '0';
        for (int i=0; i<100; i++) {
            sta[i] = '\0';
        }
        price = '0';
        interval = '0';
        speed = '0';
    };
};


#endif /* defined(__BusSystem__BusLine__) */

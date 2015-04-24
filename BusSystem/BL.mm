//
//  BL.m
//  BusSystem
//
//  Created by 董思言 on 15/4/11.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#import "BL.h"
#include <iostream>

@implementation BL


-(id)init:(BusLine)aBl{
    if (self=[super init]) {
        
        _sta = [[NSMutableArray alloc]init];
        _bl = aBl;
//初始化number
        char numberA[1];
        numberA[0] = aBl.number;
        char numberC = numberA[0];
        const char* numberPass = &numberC;
        _number = [[NSString alloc]initWithUTF8String:numberPass];
        
//初始化sta
        for(int i=0; i<aBl.count; i++){
            char c = aBl.sta[i];
            char* passChar = &c;
            NSString* pass = [[NSString alloc]initWithUTF8String:passChar];
            [_sta addObject:pass];
        }
        /*
        for (int i=0; i<aBl.count; i++) {
            NSLog(@"初始化后的_sta数组：%@\n", _sta[i]);
        }
         */
        
//初始化price
        char priceA[2];
        priceA[0] = aBl.price;
        priceA[1] = '\0';
        _price = [[NSString alloc]initWithUTF8String:&priceA[0]];

//初始化interval
        char intervalA[2];
        intervalA[0] = aBl.interval;
        intervalA[1] = '\0';
        _interval = [[NSString alloc]initWithUTF8String:&intervalA[0]];
        
//初始化speed
        char speedA[2];
        speedA[0] = aBl.speed;
        speedA[1] = '\0';
        _speed = [[NSString alloc]initWithUTF8String:&speedA[0]];
        
//初始化count
        _count = aBl.count;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_number forKey:@"number"];
    NSArray *passSta = [[NSArray alloc]initWithArray:_sta];
    [aCoder encodeObject:passSta forKey:@"sta"];
    [aCoder encodeObject:_price forKey:@"price"];
    [aCoder encodeObject:_interval forKey:@"interval"];
    [aCoder encodeObject:_speed forKey:@"speed"];
    NSString* countString = [[NSString alloc]initWithFormat:@"%d", _count];
    [aCoder encodeObject:countString forKey:@"count"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    _number = [aDecoder decodeObjectForKey:@"number"];
    _sta = [[NSMutableArray alloc]initWithArray:[aDecoder decodeObjectForKey:@"sta"]];
    _price = [aDecoder decodeObjectForKey:@"price"];
    _interval = [aDecoder decodeObjectForKey:@"interval"];
    _speed = [aDecoder decodeObjectForKey:@"speed"];
    _count = [[aDecoder decodeObjectForKey:@"count"] integerValue];
    _bl.number = *[_number UTF8String];
    for (int i=0; i<_sta.count; i++) {
        char pass = *[[_sta objectAtIndex:i] UTF8String];
        _bl.sta[i] = pass;
    }
    _bl.price = *[_price UTF8String];
    _bl.interval = *[_interval UTF8String];
    _bl.speed = *[_speed UTF8String];
    _bl.count = _count;
    return self;
}

- (BusLine)getBusLine{
    return _bl;
}

@end

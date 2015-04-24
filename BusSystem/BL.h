//
//  BL.h
//  BusSystem
//
//  Created by 董思言 on 15/4/11.
//  Copyright (c) 2015年 董思言. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "BusLine.h"

@interface BL : NSObject<NSCoding>{
}

@property BusLine bl;
@property (copy, nonatomic)NSString *number;
@property NSMutableArray *sta;
@property NSString *price;
@property NSString *interval;
@property NSString *speed;
//@property NSString *count;
@property int count;

- (id)init:(BusLine)aBl;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (BusLine)getBusLine;

@end

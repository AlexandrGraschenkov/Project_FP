//
//  NSArray+FlattenMap.m
//  TestFP
//
//  Created by Alexander on 17.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "NSArray+FlattenMap.h"

@implementation NSArray (FlattenMap)

- (NSArray *)flattenMap
{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSArray *elem in self) {
        if (![elem isKindOfClass:[NSArray class]]) continue;
        [arr addObjectsFromArray:elem];
    }
    return [arr copy];
}

@end

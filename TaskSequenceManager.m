//
//  TaskSequenceManager.m
//  TestFP
//
//  Created by Alexander on 17.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "TaskSequenceManager.h"

@implementation TaskSequenceManager

+ (void)rutTask:(NSArray *)tasks obj:(id)obj completion:(CompletionBlock)completion
{
    TaskBlock block = [tasks firstObject];
    if (!block && completion) {
        completion(obj, nil);
        return;
    }
    
    block(obj, ^(id obj, NSError *err){
        if (err) {
            completion(nil ,err);
            return;
        }
        NSMutableArray *arr = [NSMutableArray arrayWithArray:tasks];
        [arr removeObjectAtIndex:0];
        [self rutTask:[arr copy] obj:obj completion:completion];
    });
}

@end

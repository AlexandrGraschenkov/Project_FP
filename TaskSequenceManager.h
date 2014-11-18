//
//  TaskSequenceManager.h
//  TestFP
//
//  Created by Alexander on 17.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(id obj, NSError *error);
typedef void(^TaskBlock)(id obj, CompletionBlock block);

@interface TaskSequenceManager : NSObject

+ (void)rutTask:(NSArray *)tasks obj:(id)obj completion:(CompletionBlock)completion;
@end

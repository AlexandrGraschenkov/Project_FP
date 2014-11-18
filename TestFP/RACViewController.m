//
//  RACViewController.m
//  TestFP
//
//  Created by Alexander on 17.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveCocoa.h>
#import <BlocksKit.h>
#import "NSArray+FlattenMap.h"


@interface RACViewController ()
{}
@property (nonatomic, weak) IBOutlet UITextField *textField;
@end


@implementation RACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    RAC(self.textField, backgroundColor) = [[[self.textField.rac_textSignal map:^id(NSString *value) {
        return @(value.length >= 4);
    }] distinctUntilChanged] map:^id(id value) {
        NSLog(@"%@", value);
        if (![value boolValue])
            return [UIColor redColor];
        else
            return [UIColor whiteColor];
    }];
    
    return;
    
    
    
    
    NSArray *arr = @[@[@1, @[@"dsd", @"fsdfs"]], @[@3, @4]];
    NSLog(@"%@", arr.flattenMap);
    
    NSArray *suit = @[@"Hearts", @"Diamonds", @"Clubs", @"Spades"];
    NSArray *ranks = @[@"6", @"7", @"8", @"9"];
    
    NSArray *allCards = [suit bk_map:^id(id s) {
        return [ranks bk_map:^id(id r) {
            return [NSString stringWithFormat:@"%@ %@", s, r];
        }];
    }].flattenMap;
    NSLog(@"%@", allCards);
}

- (RACSignal *)testSignal
{
    static int k = 0;
    k++;
    int kk = k;
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"%@", @"XXXXXXXXX");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@(kk)];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    return signal;
}
@end

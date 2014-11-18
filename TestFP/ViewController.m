//
//  ViewController.m
//  TestFP
//
//  Created by Alexander on 17.11.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "TaskSequenceManager.h"
#import <ReactiveCocoa.h>



@interface ViewController () <UIAlertViewDelegate>
{}
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSession *session = [NSURLSession sharedSession];
    
    TaskBlock task1 = ^(NSURL *url, CompletionBlock block){
        [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            block(data, error);
        }] resume];
    };
    TaskBlock task2 = ^(NSData *obj, CompletionBlock block) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *img = [UIImage imageWithData:obj];
            NSError *err = !img? [NSError errorWithDomain:@"" code:123 userInfo:@{}] : nil;
            block(img, err);
        });
    };
    
    NSURL *url = [NSURL URLWithString:@"http://cs312722.vk.me/v312722995/5190/CJTmDr5PzMI.jpg"];
    [TaskSequenceManager rutTask:@[task1, task2] obj:url completion:^(id obj, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgView.image = obj;
        });
    }];
}


- (void)asyncTask:(NSData *)data completion:(void(^)(UIImage *, NSError *))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [[UIImage alloc] initWithData:data];
        completion(image, nil);
    });
}















@end

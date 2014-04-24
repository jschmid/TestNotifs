//
//  TAViewController.m
//  TestAsync
//
//  Created by Jonas Schmid on 24/04/14.
//  Copyright (c) 2014 schmid. All rights reserved.
//

#import "TAViewController.h"
#import "TAAsyncCallback.h"

@interface TAViewController ()

@end

@implementation TAViewController {
@private
  TAAsyncCallback *_async;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)localClick:(id)sender {
  TAAsyncCallback *async = [TAAsyncCallback new];
  [async launch];
}

- (IBAction)globalClick:(id)sender {
  _async = [TAAsyncCallback new];
  [_async launch];
}

- (IBAction)sendClick:(id)sender {
  NSNotificationCenter *nsCenter = [NSNotificationCenter defaultCenter];
  [nsCenter postNotificationName:@"notif" object:self userInfo:nil];
  NSLog(@"Notif sent");
}

@end

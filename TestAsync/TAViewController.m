//
//  TAViewController.m
//  TestAsync
//
//  Created by Jonas Schmid on 24/04/14.
//  Copyright (c) 2014 schmid. All rights reserved.
//

#import "TAViewController.h"
#import "TAAsyncCallback.h"
#import "TAAsyncOperation.h"

@interface TAViewController ()
@property TAAsyncCallback *asyncProperty;
@end

@implementation TAViewController {
@private
  TAAsyncCallback *_asyncIvar;
}

- (IBAction)localClick:(id)sender {
  TAAsyncCallback *asyncLocal = [TAAsyncCallback new];
  [asyncLocal registerNotification];
}

- (IBAction)ivarClick:(id)sender {
  _asyncIvar = [TAAsyncCallback new];
  _asyncIvar.callback = ^{ _asyncIvar = nil; };
  [_asyncIvar registerNotification];
}

- (IBAction)propertyClick:(id)sender {
  self.asyncProperty = [TAAsyncCallback new];
  __weak TAViewController *weakSelf = self;
  self.asyncProperty.callback = ^{ weakSelf.asyncProperty = nil; };
  [self.asyncProperty registerNotification];
}

- (IBAction)operationClick:(id)sender {
  TAAsyncOperation *asyncOperation = [TAAsyncOperation new];
  asyncOperation.completionBlock = ^{ NSLog(@"Completed"); };
  [asyncOperation start];
}

- (IBAction)sendClick:(id)sender {
  NSNotificationCenter *nsCenter = [NSNotificationCenter defaultCenter];
  [nsCenter postNotificationName:@"notif" object:self userInfo:nil];
  NSLog(@"Notif sent");
}

@end

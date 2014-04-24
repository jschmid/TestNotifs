//
//  TAAsyncCallback.m
//  TestAsync
//
//  Created by Jonas Schmid on 24/04/14.
//  Copyright (c) 2014 schmid. All rights reserved.
//

#import "TAAsyncCallback.h"

@implementation TAAsyncCallback

- (instancetype)init {
  NSLog(@"init");
  return [super init];
}

- (void)registerNotification {
  NSNotificationCenter *nsCenter = [NSNotificationCenter defaultCenter];
  [nsCenter addObserver:self
               selector:@selector(theCallback)
                   name:@"notif"
                 object:nil];
}

- (void)unregisterNotification {
  NSNotificationCenter *nsCenter = [NSNotificationCenter defaultCenter];
  [nsCenter removeObserver:self name:@"notif" object:nil];
}

- (void)theCallback {
  NSLog(@"Called back");
  if (self.callback) {
    self.callback();
  }
}

- (void)dealloc {
  NSLog(@"Dealloc");
  [self unregisterNotification];
}

@end

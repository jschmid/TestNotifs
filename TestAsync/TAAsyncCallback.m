//
//  TAAsyncCallback.m
//  TestAsync
//
//  Created by Jonas Schmid on 24/04/14.
//  Copyright (c) 2014 schmid. All rights reserved.
//

#import "TAAsyncCallback.h"

@implementation TAAsyncCallback

- (void)launch {
  NSNotificationCenter *nsCenter = [NSNotificationCenter defaultCenter];
  [nsCenter addObserver:self
               selector:@selector(theCallback)
                   name:@"notif"
                 object:nil];

  NSLog(@"Leaving launch");
}

- (void)theCallback {
  NSLog(@"Called back");
}

- (void)dealloc {
  NSLog(@"Dealloc");

  NSNotificationCenter *nsCenter = [NSNotificationCenter defaultCenter];
  [nsCenter removeObserver:self name:@"notif" object:nil];
}

@end

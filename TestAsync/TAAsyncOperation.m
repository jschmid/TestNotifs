//
//  TAAsyncOperation.m
//  TestAsync
//
//  Created by Jonas Schmid on 25/04/14.
//  Copyright (c) 2014 schmid. All rights reserved.
//

#import "TAAsyncOperation.h"

// Example from:
// http://codereview.stackexchange.com/questions/36632/canonical-implementation-of-a-subclass-of-nsoperation

@implementation TAAsyncOperation {
@private
  BOOL _isExecuting;
  BOOL _isFinished;

  dispatch_queue_t _syncQueue;
  id _self; // immortality
}

- (instancetype)init {
  NSLog(@"init");
  if (self = [super init]) {
    _syncQueue = dispatch_queue_create("pro.schmid.ios.TestAsync", NULL);
  }
  return self;
}

- (void)dealloc {
  NSLog(@"Dealloc");
  [self unregisterNotification];
}

- (BOOL)isConcurrent {
  return YES;
}

- (BOOL)isExecuting {
  return _isExecuting;
}
- (void)setIsExecuting:(BOOL)isExecuting {
  if (_isExecuting != isExecuting) {
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = isExecuting;
    [self didChangeValueForKey:@"isExecuting"];
  }
}

- (BOOL)isFinished {
  return _isFinished;
}
- (void)setIsFinished:(BOOL)isFinished {
  if (_isFinished != isFinished) {
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = isFinished;
    [self didChangeValueForKey:@"isFinished"];
  }
}

- (void)start {
  dispatch_async(_syncQueue, ^{
      if (!self.isCancelled && !_isFinished && !_isExecuting) {
        self.isExecuting = YES;
        _self = self;
        [self registerNotification];
      }
  });
}

- (void)finish {
  self.isExecuting = NO;
  self.isFinished = YES;
  _self = nil;
}

- (void)theCallback {
  NSLog(@"Called back");
  dispatch_async(_syncQueue, ^{ [self finish]; });
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

@end

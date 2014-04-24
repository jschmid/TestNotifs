//
//  TAAsyncCallback.h
//  TestAsync
//
//  Created by Jonas Schmid on 24/04/14.
//  Copyright (c) 2014 schmid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAAsyncCallback : NSObject

@property(copy) void (^callback)(void);

- (void)registerNotification;

@end

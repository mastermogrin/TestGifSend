//
//  SSControllerManager.h
//  ServicesSector
//
//  Created by KonstEmelyantsev on 10/15/15.
//  Copyright © 2015 KonstEmelyantsev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSControllerManager : NSObject

+ (instancetype)sharedManager;

+ (UIViewController *)topMostController;
+ (UIViewController *)currentController;

- (void)showBlockView;
- (void)hideBlockView;

@end

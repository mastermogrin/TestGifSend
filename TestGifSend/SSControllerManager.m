//
//  SSControllerManager.m
//  ServicesSector
//
//  Created by KonstEmelyantsev on 10/15/15.
//  Copyright © 2015 KonstEmelyantsev. All rights reserved.
//

#import "SSControllerManager.h"
#import <UIKit/UIKit.h>

@interface SSControllerManager ()

@property (weak, nonatomic) UIView *blockView;

@end

@implementation SSControllerManager

+ (instancetype)sharedManager {
    static SSControllerManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)showBlockView {
    if(!self.blockView) {
        UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
        
        UIViewController *curVC = topController;

        UIView *blockView = [[UIView alloc]initWithFrame:curVC.view.bounds];
        blockView.backgroundColor = [UIColor clearColor];
        UIActivityIndicatorView *aInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        aInd.hidden = NO;
        aInd.center = blockView.center;
        
        [aInd setColor:[UIColor grayColor]];
            
        [blockView addSubview:aInd];
        [aInd startAnimating];
        
        self.blockView = blockView;
        self.blockView.alpha = 0;
        self.blockView.hidden = NO;
        
        [curVC.view addSubview:self.blockView];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.blockView.alpha = 1;
        }];
    }
}

- (void)hideBlockView {
    self.blockView.alpha = 0.1;
    [UIView animateWithDuration:0.3 animations:^{
        self.blockView.alpha = 0;
    } completion:^(BOOL finished) {
        if(finished) {
            [self.blockView removeFromSuperview];
            self.blockView = nil;
        }
    }];
}

+ (UIViewController *)topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

+ (UIViewController *)currentController {
    UINavigationController *navVc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVc = [navVc.viewControllers lastObject];
    return topVc;
}

@end

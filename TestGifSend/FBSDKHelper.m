//
//  FSDKHelper.m
//  ServicesSector
//
//  Created by KonstEmelyantsev on 7/30/16.
//  Copyright © 2016 KonstEmelyantsev. All rights reserved.
//

#import "FBSDKHelper.h"
#import <UIKit/UIKit.h>
#import "SSControllerManager.h"

#define APP_LINK @"http://sferauslug.org"

@interface FBSDKHelper() <FBSDKSharingDelegate>

@property (nonatomic, strong) void (^postSuccess)(void);
@property (nonatomic, strong) void (^postFail)(NSError *error);

@end

@implementation FBSDKHelper

+ (instancetype)sharedInstance
{
    static FBSDKHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _auth = NO;
    }
    return self;
}

- (void)authSuccess:(void (^)(void))success fail:(void (^)(NSError *error))fail
{
    if (self.isAuth)
        success();
    
    if ([FBSDKAccessToken currentAccessToken])
        success();
    
    FBSDKLoginManager *login = [FBSDKLoginManager new];
    
//    [login logInWithPublishPermissions:@[@"public_profile"] fromViewController:[SSControllerManager topMostController] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//        if (error) {
//            _auth = NO;
//            fail(error);
//        } else if (result.isCancelled) {
//            
//        } else {
//            _auth = YES;
//            success();
//        }
//    }];
    
    [login logInWithReadPermissions:@[@"public_profile"] fromViewController:[SSControllerManager topMostController] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            _auth = NO;
            fail(error);
        } else if (result.isCancelled) {
            
        } else {
            _auth = YES;
            success();
        }
    }];
}

- (void)sendMessageToConversation:(NSString *)conversationId success:(void (^)(id result))success fail:(void (^)(NSError *error))fail {
    NSDictionary *params = @{
                             @"message": @"This is a test message",
                             };
    NSString *graphPath = [NSString stringWithFormat:@"/%@/messages", conversationId];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:graphPath
                                  parameters:params
                                  HTTPMethod:@"POST"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        if (!error) {
            success(result);
        } else {
            fail(error);
        }
    }];
}

- (void)fetchConversationForPage:(NSString *)pageId success:(void (^)(id result))success fail:(void (^)(NSError *error))fail {
    
    NSString *graphPath = [NSString stringWithFormat:@"/%@/conversations", pageId];

    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:graphPath
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        if (!error) {
            success(result);
        } else {
            fail(error);
        }
    }];
}

- (void)postDataToWallSuccess:(void (^)(void))success fail:(void (^)(NSError *error))fail {
    self.postSuccess = success;
    self.postFail = fail;
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:APP_LINK];
    [FBSDKShareDialog showFromViewController:[SSControllerManager topMostController]
                                 withContent:content
                                    delegate:self];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    self.postFail(error);
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    if (results[@"postId"]) {
        self.postSuccess();
    }
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    
}

@end

//
//  FSDKHelper.h
//  ServicesSector
//
//  Created by KonstEmelyantsev on 7/30/16.
//  Copyright © 2016 KonstEmelyantsev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface FBSDKHelper : NSObject

@property (nonatomic, assign, getter = isAuth) BOOL auth;

+ (instancetype)sharedInstance;

- (void)postDataToWallSuccess:(void (^)(void))success fail:(void (^)(NSError *error))fail;
- (void)authSuccess:(void (^)(void))success fail:(void (^)(NSError *error))fail;

- (void)sendMessageToConversation:(NSString *)conversationId success:(void (^)(id result))success fail:(void (^)(NSError *error))fail;
- (void)fetchConversationForPage:(NSString *)pageId success:(void (^)(id result))success fail:(void (^)(NSError *error))fail;

@end

//
//  ViewController.m
//  TestGifSend
//
//  Created by KonstEmelyantsev on 11/6/16.
//  Copyright © 2016 KonstEmelyantsev. All rights reserved.
//

#import "ViewController.h"
#import "FBSDKHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookClick:(id)sender {
    [[FBSDKHelper sharedInstance] authSuccess:^{
        
    } fail:^(NSError *error) {
        
    }];
}

- (IBAction)twitterClick:(id)sender {
}

@end

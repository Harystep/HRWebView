//
//  BaseViewController.m
//  HRWebView
//
//  Created by 八点半 on 2019/5/8.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "BaseViewController.h"
#import "HRWebViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)jumpInto:(id)sender {
    HRWebViewController *webVc = [[HRWebViewController alloc] init];
    [self.navigationController pushViewController:webVc animated:YES];
}

@end

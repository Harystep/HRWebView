//
//  ViewController.m
//  HRWebView
//
//  Created by 八点半 on 2019/5/8.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRWebViewController.h"
#import <WebKit/WebKit.h>

#define k_width [UIScreen mainScreen].bounds.size.width
#define k_height [UIScreen mainScreen].bounds.size.height
#define k_statusBar [UIApplication sharedApplication].statusBarFrame.size.height
#define k_navBar self.navigationController.navigationBar.frame.size.height

@interface HRWebViewController () <WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *WKWebView;

@property (nonatomic,strong) UIView *progresslayer;

@end

@implementation HRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.WKWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, k_statusBar + k_navBar, k_width, k_height-(k_statusBar + k_navBar))];
    self.WKWebView.navigationDelegate = self;
    NSString *linkStr = @"https://s.top/h5/#/pages/agreement?lang=cn";
    [self.view addSubview:self.WKWebView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:linkStr]];
    [self.WKWebView loadRequest:request];
    
    
    self.progresslayer = [[UIView alloc] init];
    self.progresslayer.frame = CGRectMake(0, k_statusBar + k_navBar, 10, 2);
    self.progresslayer.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.progresslayer];
    
    [self.WKWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}

// 观察者
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progresslayer.hidden = NO;
        float floatNum = [[change objectForKey:@"new"] floatValue];
        
        self.progresslayer.frame = CGRectMake(0, self.progresslayer.frame.origin.y, k_width*floatNum, 2);
        
        if (floatNum == 1) {
            
            __weak __typeof(self)weakSelf = self;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.progresslayer.hidden = YES;
                
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                weakSelf.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
        
    }else{
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)dealloc{
    
    [self.WKWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end

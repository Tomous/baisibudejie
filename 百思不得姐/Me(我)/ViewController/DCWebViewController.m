//
//  DCWebViewController.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/2/15.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCWebViewController.h"

@interface DCWebViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation DCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}
- (IBAction)back {
    [self.webView goBack];
}
- (IBAction)forward {
    [self.webView goForward];
}
- (IBAction)reload {
    [self.webView reload];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

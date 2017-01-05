//
//  ViewController.m
//  LoadGIF
//
//  Created by ZhengWei on 16/4/26.
//  Copyright © 2016年 Bourbon. All rights reserved.
//

#import "ViewController.h"
#import "CGImageGIFView.h"
#import "CAKeyframeAnimationGIFView.h"
#import "CADisplayLineImageView.h"
@interface ViewController ()
{
    CGImageGIFView *gifView;
    CAKeyframeAnimationGIFView *otherGifView;
    CADisplayLineImageView *displayImageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadGIFWithCGImage];
    //[self loadCADisplayLineImageView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadGIFWithWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 350*2, 393)];
    [webView setCenter:self.view.center];
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"2" ofType:@"gif"]];
    webView.userInteractionEnabled = NO;
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
    //设置webview背景透明，能看到gif的透明层
    webView.backgroundColor = [UIColor blackColor];
    webView.opaque = NO;
    [self.view addSubview:webView];
    
}
-(void)loadGIFWithCGImage
{
    
    UIImage* iconImage = [UIImage imageNamed:@"icon.png"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"gif"];
    for (int i = 0;i<1;i++) {
        gifView = [[CGImageGIFView alloc] initWithGIFPath:path];
        gifView.frame = CGRectMake(20,20, 200, 200);
        [self.view addSubview:gifView];
        gifView.updateImage = ^(CGContextRef ctx,size_t index) {
            CGContextDrawImage(ctx, CGRectMake(index*5,index*5, 60, 60), iconImage.CGImage);
        };
        [gifView startGIF];
    }
    
}
-(void)loadCAKeyframeAnimation
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"gif"];
    otherGifView = [[CAKeyframeAnimationGIFView alloc] initWithCAKeyframeAnimationWithPath:path];
    otherGifView.center = self.view.center;
    [self.view addSubview:otherGifView];
    [otherGifView startGIF];
}
-(void)loadCADisplayLineImageView
{
    displayImageView = [[CADisplayLineImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [displayImageView setCenter:self.view.center];
    [self.view addSubview:displayImageView];
    [displayImageView setImage:[CADisplayLineImage imageNamed:@"1.gif"]];
    
}
@end

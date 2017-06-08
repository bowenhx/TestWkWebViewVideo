//
//  VideoView.m
//  TestWkWebViewVideo
//
//  Created by ligb on 2017/4/11.
//  Copyright © 2017年 com.mobile-kingdom.ekapps. All rights reserved.
//

#import "VideoView.h"

@implementation VideoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addWebView];
    }
    return self;
}


/**
 添加一个webView
 */
- (void)addWebView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.mediaPlaybackRequiresUserAction = NO;//把手动播放设置NO ios(8.0, 9.0)
    config.allowsInlineMediaPlayback = YES;//是否允许内联(YES)或使用本机全屏控制器(NO)。默认值是否定的。
    config.mediaPlaybackAllowsAirPlay = YES;//允许播放，默认是YES
//    config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAll;
//    config.allowsPictureInPictureMediaPlayback = YES;
//    config.mediaTypesRequiringUserActionForPlayback = NO;
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) configuration:config];
    _wkWebView.layer.borderWidth = 1;
    _wkWebView.layer.borderColor = [UIColor redColor].CGColor;
    _wkWebView.navigationDelegate = self;
    _wkWebView.UIDelegate = self;
    
    [_wkWebView.scrollView setScrollEnabled:NO];//禁止滚动
    [self addSubview:_wkWebView];
    
    //本地html测试
    NSString * htmlPath = [NSBundle.mainBundle pathForResource:@"index" ofType:@"html"];
    NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
    
    //这里需要判断下版本，来加载
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 9.0) {
        [_wkWebView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    }else{
        NSURL *endURL = [self fileURLForBuggyWKWebView8:fileURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:endURL];
        [_wkWebView loadRequest:request];
    }

    //网页html测试
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://i.gugubaby.com/resources/ad_movietest.php"]];
//    [_wkWebView loadRequest:request];
    
   
}


/**
 把本地html 重新copy 一个文件夹

 @param fileURL 本地url
 @return 存储的 url
 */
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"tempHTML"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

#pragma mark - WKNavigationDelegate
- (void)playVideo{
    NSString *script = @"var videos = document.querySelectorAll(\"video\"); for (var i = videos.length - 1; i >= 0; i--) { var ivideo = videos[i]; ivideo.setAttribute(\"webkit-playsinline\",\"\"); ivideo.play(); };";
    [_wkWebView evaluateJavaScript:script completionHandler:nil];
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
    [self playVideo];
}



/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //这里做交互处理
//    NSString *url = [[navigationAction.request URL] absoluteString];
    
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    
}


@end

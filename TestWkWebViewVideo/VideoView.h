//
//  VideoView.h
//  TestWkWebViewVideo
//
//  Created by ligb on 2017/4/11.
//  Copyright © 2017年 com.mobile-kingdom.ekapps. All rights reserved.
//
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width

@interface VideoView : UIView<WKNavigationDelegate,UIWebViewDelegate,WKUIDelegate>
//wkwebView
@property (nonatomic, strong) WKWebView *wkWebView;


@end

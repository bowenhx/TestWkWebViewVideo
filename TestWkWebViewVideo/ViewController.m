//
//  ViewController.m
//  TestWkWebViewVideo
//
//  Created by ligb on 2017/4/11.
//  Copyright © 2017年 com.mobile-kingdom.ekapps. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "ViewController.h"
#import "VideoView.h"

@interface ViewController ()
@property (nonatomic , strong) VideoView *iView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这里初始化一个固定的view存放wkWebView
    _iView = [[VideoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    _iView.tag = 100;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 5)
        return 300.0;
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //test height
    if(indexPath.row == 5)
        return 300.0;
    return 40.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defineCell = @"defineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defineCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:defineCell];
        if (indexPath.row == 5) {
            [cell.contentView addSubview:_iView];
        }
    }
    
    if (indexPath.row == 5) {
        UIView *subView = [cell.contentView viewWithTag:100];
        cell.textLabel.text = @"";
        subView.hidden = NO;
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"cell_index_%ld",indexPath.row];
        UIView *subView = [cell.contentView viewWithTag:100];
        subView.hidden = YES;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

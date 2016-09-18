//
//  ViewController.m
//  YLPageScrollController
//
//  Created by SYLing on 16/9/18.
//  Copyright © 2016年 MOLMC. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "YLTabScrollPageController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *tabArray = [NSArray arrayWithObjects:@"标签1", @"标签2", @"标签3", @"标签4", nil];
    NSMutableArray *pageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < tabArray.count; i ++) {
        //        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        if (i == 0) {
            OneViewController *one = [[OneViewController alloc] init];
            
            [pageArray addObject:one];
        } else if(i == 1) {
            
            TwoViewController *webViewViewController = [[TwoViewController alloc] init];
            
            [pageArray addObject:webViewViewController];
        } else if(i == 2) {
            ThreeViewController *webViewViewController2 = [[ThreeViewController alloc] init];
            [pageArray addObject:webViewViewController2];
        }else if(i == 3) {
            FourViewController *webViewViewController3 = [[FourViewController alloc] init];
            [pageArray addObject:webViewViewController3];
        }
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //选项滚动页视图
    YLTabScrollPageController *tabScrollPageController = [[YLTabScrollPageController alloc] initWithTabFatherView:self.view tabScrollViewFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40) pageFatherView:self.view pageScrollViewFrame:CGRectMake(0, 64+40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - (64+40)) tabArray:tabArray pageArray:pageArray FatherViewController:self numberOfTabAtOnePage:4];
    [tabScrollPageController addToSuperView];
    tabScrollPageController.tabScrollView.tabMagin = 10;
    tabScrollPageController.tabScrollView.showTabSeparatedLineView = YES;
    tabScrollPageController.tabScrollView.showSeparatedUnderline = YES;
    tabScrollPageController.tabScrollView.separatedLineColor = [UIColor grayColor];
    tabScrollPageController.tabScrollView.separatedLineHeight = 0.5;
    tabScrollPageController.tabScrollView.tabSeparatedLineHeight = 14;
    tabScrollPageController.tabScrollView.backgroundColor = [UIColor whiteColor];
    tabScrollPageController.tabScrollView.foregroundColor = [UIColor blackColor];
    tabScrollPageController.tabScrollView.highlightColor = [UIColor blueColor];
    
    // 滚动切换界面
    tabScrollPageController.pageScrollView.scrollEnabled = NO;
}

@end

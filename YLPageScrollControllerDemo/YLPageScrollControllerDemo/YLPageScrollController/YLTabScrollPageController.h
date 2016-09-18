//
//  YLTabScrollPageController.h
//  YLPageScrollController
//
//  Created by SYLing on 16/9/18.
//  Copyright © 2016年 MOLMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLTabScrollView.h"
#import "YLPageScrollView.h"
#import "UIView+Utils.h"

@class YLTabScrollPageController;
@protocol YLTabScrollPageControllerDelegate <NSObject>

//选中一个
/**
 注意: 请不要在这个方法里对未加载的页面进行操作,否则可能会无效
 */
@optional
- (void)tabScrollPageController:(YLTabScrollPageController *)tabScrollPageController didSelectAtIndex:(NSInteger)index;

//已经滚动到下标
- (void)tabScrollPageController:(YLTabScrollPageController *)tabScrollPageController didScrollToIndex:(NSInteger)index;
@end

/**
 *  标签滚动页控制器
 *
 *  @author apem
 */

@interface YLTabScrollPageController : UIView<YLTabScrollViewDelegate, YLPageScrollViewDelegate>

@property (nonatomic, strong) YLTabScrollView *tabScrollView;         //标签滚动视图
@property (nonatomic, strong) YLPageScrollView *pageScrollView;       //页滚动视图
@property (nonatomic, assign) CGRect pageScrollViewFrame;   //页滚动视图的frame
@property (nonatomic, strong) id<YLTabScrollPageControllerDelegate> delegate;

/**
 *  初始化
 *
 *  @param tabScrollViewFrame 标签滚动视图的frame
 *  @param pageScrollViewFrame 页滚动视图的frame
 *  @param tabArray       标签名称数组
 *  @param pageArray      页数组 view/controller 数组
 *  @param numberOfTabAtOnePage 选项卡的数量每页
 *
 *  @return 标签滚动页控制器
 */
- (instancetype)initWithTabFatherView:(UIView *)tabFatherView tabScrollViewFrame:(CGRect)tabScrollViewFrame pageFatherView:(UIView *)pageFatherView pageScrollViewFrame:(CGRect)pageScrollViewFrame tabArray:(NSArray *)tabArray pageArray:(NSArray *)pageArray FatherViewController:(UIViewController *)fatherViewController numberOfTabAtOnePage:(NSInteger)numberOfTabAtOnePage;

/**
 *  初始化
 */
- (void)setup;

/**
 *  添加进入对应的父视图
 */
- (void)addToSuperView;
@end

//
//  YLPageScrollView.h
//  YLPageScrollController
//
//  Created by SYLing on 16/9/18.
//  Copyright © 2016年 MOLMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Utils.h"

@class YLPageScrollView;
@protocol YLPageScrollViewDelegate <NSObject>

@required
//页数
- (NSInteger)numberOfPage:(YLPageScrollView *)pageScrollView;

//指定下标的页视图
- (id)pageScrollView:(YLPageScrollView *)pageScrollView  pageViewAtIndex:(NSInteger)index;

@optional
//正在滚动
- (void)pageScrollViewDidScroll:(YLPageScrollView *)pageScrollView;

//已经滚动到下标
- (void)pageScrollView:(YLPageScrollView *)pageScrollView didScrollToIndex:(NSInteger)index;

@end

/**
 *  页滚动视图
 *
 *  @author apem
 */

@interface YLPageScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, assign, readonly) NSInteger currentIndex;       //当前下标
@property (nonatomic, assign) id<YLPageScrollViewDelegate> pageScrollViewdelegate;    //委托
@property (nonatomic, assign) BOOL warmAnimated;      //和谐动画 默认NO
@property (nonatomic, assign) BOOL loadNearPage; //加载邻近的页 default is YES
@property (nonatomic, assign) BOOL loadImmediately; //一触发跳转页面就立刻加载 default is NO

/**
 *  初始化
 *
 *  @param frame    位置和大小
 *  @param delegate 委托
 *
 *  @return 页滚动视图
 */
- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id<YLPageScrollViewDelegate>)delegate;

/**
 *  初始化
 */
- (void)setup;

/**
 *  滚动到指定下标
 *
 *  @param index 下标
 */
- (void)scrollToIndex:(NSInteger)index;

//重新加载所有页 (未测试)
- (void)reloadAllPage;

@end

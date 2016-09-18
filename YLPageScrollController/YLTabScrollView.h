//
//  YLTabScrollView.h
//  YLPageScrollController
//
//  Created by SYLing on 16/9/18.
//  Copyright © 2016年 MOLMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Utils.h"
@class YLTabScrollView;
@protocol YLTabScrollViewDelegate <NSObject>

//多少个选项卡每页
@required
- (NSInteger)numberOfTabAtOnePage:(YLTabScrollView *)tabScrollView;

//选显卡数据源数组
@required
- (NSArray *)arrayForTabDataSource:(YLTabScrollView *)tabScrollView;

//选项被选中
@optional
- (void)tabScrollView:(YLTabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index;

@end

//标签选中滑动视图

@interface YLTabScrollView : UIScrollView

@property (nonatomic, strong) UIScrollView *innerScrollView;                    //滚动视图
@property (nonatomic, strong) UIView *underLineV;                               //下划线视图

@property (nonatomic, strong) UIColor *foregroundColor;                         //前景色
@property (nonatomic, strong) UIColor *highlightColor;                          //高亮色
@property (nonatomic, strong) UIFont *font;                                     //字体
@property (nonatomic, assign) CGFloat tabMagin;                                 //边距
@property (nonatomic, assign) BOOL animated;                                    //是否允许动画 默认YES
@property (nonatomic, assign) BOOL animating;                                   //是否正在执行动画
@property (nonatomic, assign) id<YLTabScrollViewDelegate> tabScrollViewDelegate;  //委托

@property (nonatomic, readonly, assign) NSInteger numberOfTabAtOnePage;         //一页多少个选项卡
@property (nonatomic, readonly, strong) NSArray *arrayForTabDataSource;         //数据源数组
@property (nonatomic, assign) NSInteger currentSelectIndex;                     //当前被选中的下标 默认:0

@property (nonatomic, strong) NSMutableArray *tabButtonArray;                   //按钮数组

@property (nonatomic, strong) UIColor *separatedLineColor;                      //分割线的颜色
@property (nonatomic, assign) CGFloat separatedLineHeight;                      //分割线高度 default is 0.5
@property (nonatomic, assign) BOOL showSeparatedUnderline;                      //是否显示分割下划线 default is YES
@property (nonatomic, assign) BOOL showTabSeparatedLineView;                    //是否显示分割下划线 default is NO
@property (nonatomic, assign) CGFloat tabSeparatedLineHeight;                   //分割线高度 default is 14
/**
 *  选中某个下标
 *
 *  @param index    下标
 *  @param animated 是否动画
 */
- (void)selectAtIndex:(NSInteger)index animated:(BOOL)animated;

@end

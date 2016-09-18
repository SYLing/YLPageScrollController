//
//  YLTabScrollPageController.m
//  YLPageScrollController
//
//  Created by SYLing on 16/9/18.
//  Copyright © 2016年 MOLMC. All rights reserved.
//

#import "YLTabScrollPageController.h"

@interface YLTabScrollPageController ()

@property (nonatomic, assign) UIView *tabFatherView;        //标签滚动视图的父视图
@property (nonatomic, assign) UIViewController *fatherViewController;        //父控制器
@property (nonatomic, assign) UIView *pageFatherView;       //页滚动视图的父视图
@property (nonatomic, assign) CGRect tabScrollViewFrame;    //标签滚动视图的frame


@property (nonatomic, strong) NSArray *tabArray;            //标签数组
@property (nonatomic, strong) NSArray *pageArray;           //数组
@property (nonatomic, assign) NSInteger numberOfTabAtOnePage;//选项卡的数量每页

@end

@implementation YLTabScrollPageController


- (instancetype)initWithTabFatherView:(UIView *)tabFatherView tabScrollViewFrame:(CGRect)tabScrollViewFrame pageFatherView:(UIView *)pageFatherView pageScrollViewFrame:(CGRect)pageScrollViewFrame tabArray:(NSArray *)tabArray pageArray:(NSArray *)pageArray  FatherViewController:(UIViewController *)fatherViewController numberOfTabAtOnePage:(NSInteger)numberOfTabAtOnePage
{
    if(self = [super init]) {
        self.tabFatherView = tabFatherView;
        self.pageFatherView = pageFatherView;
        self.tabScrollViewFrame = tabScrollViewFrame;
        self.pageScrollViewFrame = pageScrollViewFrame;
        self.tabArray = tabArray;
        self.pageArray = pageArray;
        self.numberOfTabAtOnePage = numberOfTabAtOnePage;
        self.fatherViewController = fatherViewController;
        [self setup];
    }
    return self;
}

- (void)addToSuperView
{
    [self.tabFatherView addSubview:self.tabScrollView];
    // 加入字控制器
    for (UIViewController *vc in self.pageArray) {
        [self.fatherViewController addChildViewController:vc];
    }
    [self.tabFatherView addSubview:self];
    [self.pageFatherView addSubview:self.pageScrollView];
}

- (void)setTabScrollViewFrame:(CGRect)tabScrollViewFrame
{
    _tabScrollViewFrame = tabScrollViewFrame;
    self.tabScrollView.frame = _tabScrollViewFrame;
}

- (void)setPageScrollViewFrame:(CGRect)pageScrollViewFrame
{
    _pageScrollViewFrame = pageScrollViewFrame;
    self.pageScrollView.frame = _pageScrollViewFrame;
}

- (void)setup
{
    _tabScrollView = [[YLTabScrollView alloc] initWithFrame:self.tabScrollViewFrame];
    _tabScrollView.tabScrollViewDelegate = self;
    _tabScrollView.animated = YES;
    
    _pageScrollView = [[YLPageScrollView alloc] initWithFrame:self.pageScrollViewFrame withDelegate:self];
    _pageScrollView.warmAnimated = YES;
}

#pragma mark - TabScrollViewDelegate

- (NSInteger)numberOfTabAtOnePage:(YLTabScrollView *)tabScrollView
{
    return self.numberOfTabAtOnePage;
}

//选显卡数据源数组
- (NSArray *)arrayForTabDataSource:(YLTabScrollView *)tabScrollView
{
    return self.tabArray;
}

//选项被选中
- (void)tabScrollView:(YLTabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index
{
    if(index != self.pageScrollView.currentIndex) {
        [self.pageScrollView scrollToIndex:index];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabScrollPageController:didSelectAtIndex:)]) {
        [self.delegate tabScrollPageController:self didSelectAtIndex:index];
    }
}

#pragma mark - PageScrollViewDelegate

//页数
- (NSInteger)numberOfPage:(YLPageScrollView *)pageScrollView
{
    return self.pageArray.count;
}

//指定下标的页视图
- (id)pageScrollView:(YLPageScrollView *)pageScrollView pageViewAtIndex:(NSInteger)index
{
    return [self.pageArray objectAtIndex:index];
}

//正在滚动
- (void)pageScrollViewDidScroll:(YLPageScrollView *)pageScrollView
{
    if (self.tabScrollView.animating == NO) {
        CGFloat widthPerPage = pageScrollView.width;
        CGFloat tabMargin = self.tabScrollView.tabMagin;
        CGFloat tabDummyWidth = (widthPerPage - tabMargin) / self.numberOfTabAtOnePage;
        
        CGFloat percent = tabDummyWidth / widthPerPage;
        
        CGFloat currentOffset = (pageScrollView.contentOffset.x * percent) + tabMargin;
        self.tabScrollView.underLineV.left = currentOffset;
    }
}

- (void)pageScrollView:(YLPageScrollView *)pageScrollView didScrollToIndex:(NSInteger)index
{
    //并没有让tabScrollView发出委托
    if(index != self.tabScrollView.currentSelectIndex) {
        [self.tabScrollView selectAtIndex:index animated:YES];
    }
    
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(tabScrollPageController:didSelectAtIndex:)]) {
    //        [self.delegate tabScrollPageController:self didSelectAtIndex:index];
    //    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabScrollPageController:didScrollToIndex:)]) {
        [self.delegate tabScrollPageController:self didScrollToIndex:index];
    }
}

#pragma mark - private methods

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end

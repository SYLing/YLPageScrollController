//
//  YLPageScrollView.m
//  YLPageScrollController
//
//  Created by SYLing on 16/9/18.
//  Copyright © 2016年 MOLMC. All rights reserved.
//

#import "YLPageScrollView.h"

@interface YLPageScrollView ()

@property (nonatomic, strong) NSMutableDictionary *pageViewDictionary;        //页字典

@end

@implementation YLPageScrollView

@synthesize currentIndex = _currentIndex;

- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id<YLPageScrollViewDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        
        _loadNearPage = YES;
        _loadImmediately = NO;
        
        self.pageScrollViewdelegate = delegate;
        [self setup];
    }
    return self;
}

- (NSMutableDictionary *)pageViewDictionary
{
    if (!_pageViewDictionary) {
        NSInteger numberOfPage = [self.pageScrollViewdelegate numberOfPage:self];
        _pageViewDictionary = [NSMutableDictionary dictionaryWithCapacity:numberOfPage];
    }
    return _pageViewDictionary;
}

- (void)setup
{
    NSInteger numberOfPage = [self.pageScrollViewdelegate numberOfPage:self];
    self.contentSize = CGSizeMake((numberOfPage * self.width), self.height);
    self.pagingEnabled = YES;
    self.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    
    //    //允许UIViewController或者UIView
    //    UIView *firstView;
    //    id obj = [self.pageScrollViewdelegate pageScrollView:self pageViewAtIndex:0];
    //    if([obj isKindOfClass:[UIViewController class]]) {
    //        UIViewController *vc = (UIViewController *)obj;
    //        [self.pageViewDictionary setObject:vc forKey:[NSNumber numberWithInteger:0]];
    //        firstView = vc.view;
    //    } else {
    //        [self.pageViewDictionary setObject:obj forKey:[NSNumber numberWithInteger:0]];
    //        firstView = obj;
    //    }
    //
    //    firstView.frame = CGRectMake(0, 0, self.width, self.height);
    //    [self addSubview:firstView];
    
    if (self.loadNearPage == YES) {
        //根据下标加载视图,并加载周边视图
        [self loadPageAndNearByByIndex:0];
    } else {
        [self loadAndResetPageFrameByIndex:0];
    }
    
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.pageScrollViewdelegate && [self.pageScrollViewdelegate respondsToSelector:@selector(pageScrollViewDidScroll:)]) {
        [self.pageScrollViewdelegate pageScrollViewDidScroll:self];
    }
    
    CGFloat calcOffset = (scrollView.contentOffset.x + scrollView.width/2) / scrollView.width;
    if (self.currentIndex != floor(calcOffset)) {
        //设置当前页
        _currentIndex = floor(calcOffset);
    }
    
    //滚动到某个下标 完成之后加载视图
    if (scrollView.contentOffset.x == (scrollView.width * _currentIndex)) {
        
        //发送委托
        if (self.pageScrollViewdelegate && [self.pageScrollViewdelegate respondsToSelector:@selector(pageScrollView:didScrollToIndex:)]) {
            [self.pageScrollViewdelegate pageScrollView:self didScrollToIndex:_currentIndex];
        }
        
        //非立刻加载页面
        if(self.loadImmediately == NO) {
            //是否加载邻近页面
            if (self.loadNearPage == YES) {
                //根据下标加载视图,并加载周边视图
                [self loadPageAndNearByByIndex:_currentIndex];
            } else {
                [self loadAndResetPageFrameByIndex:_currentIndex];
            }
        }
        
        //        //如果当前页还未加载视图则加载
        //        id obj = [self.pageViewDictionary objectForKey:[NSNumber numberWithInteger:_currentIndex]];
        //        if (!obj) {
        //            obj = [self.pageScrollViewdelegate pageScrollView:self pageViewAtIndex:_currentIndex];
        //            [self.pageViewDictionary setObject:obj forKey:[NSNumber numberWithInteger:_currentIndex]];
        //        }
        //
        //        UIView *theView;
        //        if([obj isKindOfClass:[UIViewController class]]) {
        //            UIViewController *vc = (UIViewController *)obj;
        //            theView = vc.view;
        //        } else {
        //            theView = obj;
        //        }
        //        theView.frame = CGRectMake(_currentIndex * self.width, 0, self.width, self.height);
        //        [self addSubview:theView];
        
    }
}

- (void)scrollToIndex:(NSInteger)index;
{
    if (self.warmAnimated == YES) {
        
        CGFloat littleNum = 2;
        if (index > _currentIndex) {
            
            [self setContentOffset:CGPointMake((index - 1) * self.width + littleNum, 0) animated:NO];
        } else if(index < _currentIndex){
            [self setContentOffset:CGPointMake((index + 1) * self.width + littleNum, 0) animated:NO];
        }
        
    }
    
    _currentIndex = index;
    
    [self setContentOffset:CGPointMake(_currentIndex * self.width, 0) animated:YES];
    
    //是否立刻加载
    if (self.loadImmediately == YES) {
        //是否加载周边页面
        if (self.loadNearPage == YES) {
            //根据下标加载视图,并加载周边视图
            [self loadPageAndNearByByIndex:_currentIndex];
        } else {
            [self loadAndResetPageFrameByIndex:_currentIndex];
        }
    }
    
    
    //    //如果当前页还未加载视图则加载
    //    id obj = [self.pageViewDictionary objectForKey:[NSNumber numberWithInteger:_currentIndex]];
    //    if (!obj) {
    //        obj = [self.pageScrollViewdelegate pageScrollView:self pageViewAtIndex:_currentIndex];
    //        [self.pageViewDictionary setObject:obj forKey:[NSNumber numberWithInteger:_currentIndex]];
    //    }
    //
    //    UIView *theView;
    //    if([obj isKindOfClass:[UIViewController class]]) {
    //        UIViewController *vc = (UIViewController *)obj;
    //        theView = vc.view;
    //    } else {
    //        theView = obj;
    //    }
    //    theView.frame = CGRectMake(_currentIndex * self.width, 0, self.width, self.height);
    //    [self addSubview:theView];
}

- (void)reloadAllPage
{
    //移除所有子视图
    NSArray *allKeys = [self.pageViewDictionary allKeys];
    [self.pageViewDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        UIView *theView;
        if([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)obj;
            theView = vc.view;
        } else {
            theView = (UIView *)obj;
        }
        
        if (theView.superview != nil) {
            [theView removeFromSuperview];
        }
        
    }];
    
    [self.pageViewDictionary removeAllObjects];
    
    //重新加载子视图
    for(NSInteger i = 0;i < allKeys.count;i ++) {
        NSNumber *key = [allKeys objectAtIndex:i];
        [self loadAndResetPageFrameByIndex:key.integerValue];
    }
    
}

#pragma mark - private methods

//根据下标 加载并重新设置页面布局
- (void)loadAndResetPageFrameByIndex:(NSInteger)index
{
    //如果当前页还未加载视图则加载
    UIView *theView;
    
    id obj = [self.pageViewDictionary objectForKey:[NSNumber numberWithInteger:index]];
    if (obj == nil) {
        obj = [self.pageScrollViewdelegate pageScrollView:self pageViewAtIndex:index];
        [self.pageViewDictionary setObject:obj forKey:[NSNumber numberWithInteger:index]];
    }
    
    if([obj isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)obj;
        theView = vc.view;
        [self addSubview:theView];
    } else {
        theView = (UIView *)obj;
        [self addSubview:theView];
    }
    
    theView.frame = CGRectMake(index * self.width, 0, self.width, self.height);
}

//根据下标加载视图,并加载周边视图
- (void)loadPageAndNearByByIndex:(NSInteger)index
{
    [self loadAndResetPageFrameByIndex:index];
    if (index - 1 >= 0) {
        [self loadAndResetPageFrameByIndex:index - 1];
    }
    
    NSInteger numberOfPage = [self.pageScrollViewdelegate numberOfPage:self];
    if (index + 1 < numberOfPage) {
        [self loadAndResetPageFrameByIndex:index + 1];
    }
}

@end

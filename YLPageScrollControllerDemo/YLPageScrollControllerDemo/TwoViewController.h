//
//  TwoViewController.h
//  ScrolllPageItem
//
//  Created by 梁惠源 on 16/9/17.
//  Copyright © 2016年 MOLMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TwoDelegate <NSObject>

- (void)addBtn;

@end
@interface TwoViewController : UIViewController

@property (nonatomic,weak) id<TwoDelegate> delegate;

@end

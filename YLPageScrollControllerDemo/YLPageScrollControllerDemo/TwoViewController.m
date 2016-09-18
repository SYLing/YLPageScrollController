//
//  TwoViewController.m
//  ScrolllPageItem
//
//  Created by 梁惠源 on 16/9/17.
//  Copyright © 2016年 MOLMC. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addBtn.center = self.view.center;
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)addBtnClick
{
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
}
@end

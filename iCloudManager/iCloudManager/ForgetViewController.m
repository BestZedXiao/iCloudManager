//
//  ForgetViewController.m
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.view);
    }];
}


@end

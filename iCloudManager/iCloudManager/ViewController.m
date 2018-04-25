//
//  ViewController.m
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

#import "ViewController.h"
#import "MXiCloudManager.h"
#import "Masonry.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iCloud";
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkICloud];
    });
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"登 录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 6;
    button.clipsToBounds = YES;
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
}

- (void)checkICloud{
    BOOL isEnable = [MXiCloudManager shareInstance].mx_iCloudIsEnable;
    if (isEnable == NO) {
        [MBProgressHUD showMsg:@"iCloud不可用,请检查配置"];
    }else{
        [MBProgressHUD showMsg:@"iCloud可正常使用"];
    }
}

- (void)login:(UIButton *)button{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
@end

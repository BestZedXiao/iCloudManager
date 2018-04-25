//
//  LoginViewController.m
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *resignButon;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passWordTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
}

- (void)creatUI{
    
    
    self.userNameTF = [[UITextField alloc] init];
    self.userNameTF.placeholder = @"请输入账号";
    [self.view addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SCREEN_HEIGHT*0.35);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 35));
    }];
    
    self.passWordTF = [[UITextField alloc] init];
    self.passWordTF.placeholder = @"请输入密码";
    [self.view addSubview:self.passWordTF];
    
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.layer.cornerRadius = 6;
    self.loginButton.clipsToBounds = YES;
    self.loginButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 45));
        
    }]
    
}

- (void)login{
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
}
@end

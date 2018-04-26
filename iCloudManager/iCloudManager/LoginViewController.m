//
//  LoginViewController.m
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "ResignViewController.h"
#import "ForgetViewController.h"
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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.view);
    }];
    
    self.userNameTF = [[UITextField alloc] init];
    self.userNameTF.placeholder = @"请输入账号";
    self.userNameTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(SCREEN_HEIGHT*0.35);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-100, 35));
    }];
    
    self.passWordTF = [[UITextField alloc] init];
    self.passWordTF.placeholder = @"请输入密码";
    self.passWordTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passWordTF];
    [self.passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTF.mas_bottom).offset(15);
        make.size.mas_equalTo(self.userNameTF);
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.layer.cornerRadius = 6;
    self.loginButton.clipsToBounds = YES;
    self.loginButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-100, 45));
        make.top.mas_equalTo(self.passWordTF.mas_bottom).offset(15);
    }];
    
    self.resignButon = [[UIButton alloc] init];
    [self.resignButon setTitle:@"register" forState:UIControlStateNormal];
    [self.resignButon setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.resignButon addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resignButon];
    [self.resignButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginButton);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    self.forgetButton = [[UIButton alloc] init];
    [self.forgetButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.forgetButton setTitle:@"forget?" forState:UIControlStateNormal];
    [self.forgetButton addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetButton];
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.loginButton);
        make.top.mas_equalTo(self.resignButon);
        make.size.mas_equalTo(self.forgetButton);
    }];
}

- (void)login{
    [self.userNameTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
    if ([self.userNameTF.text isEqualToString:@""] || [self.passWordTF.text isEqualToString:@""]) {
        [MBProgressHUD showMsg:@"账号或密码为空!"];
        return;
    }
    
    [MBProgressHUD showLoadingWithMsg:@"正在登陆..."];
    [[MXiCloudManager shareInstance] mx_fetchICloudDataWithZoneTypeisPublic:YES recordName:self.userNameTF.text finishBlock:^(UserModel *userModel, NSError *error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.userNameTF.text isEqualToString:userModel.userName] && [self.passWordTF.text isEqualToString:userModel.passWord]) {
                [MBProgressHUD hide];
                MainViewController *main = [[MainViewController alloc] init];
                [self.navigationController pushViewController:main animated:YES];
            }else{
                [MBProgressHUD showMsg:@"账号或密码错误!"];
            }
        });
 
    }];
}

- (void)resign{
    ResignViewController *resign = [[ResignViewController alloc] init];
    [self.navigationController pushViewController:resign animated:YES];
}

- (void)forget{
    ForgetViewController *forget = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
}
@end

//
//  ResignViewController.m
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

#import "ResignViewController.h"

@interface ResignViewController ()

@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UITextField *checkPasswordTF;
@property (nonatomic, strong) UITextField *ageTF;
@property (nonatomic, copy) NSString *creatTime;
@end

@implementation ResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
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
        make.top.mas_equalTo(SCREEN_HEIGHT*0.35);
        make.left.mas_equalTo(SCREEN_WIDTH*0.3);
        make.size.mas_equalTo(CGSizeMake(SCALE_WIDTH(200), 35));
    }];
    
    UILabel *userName = [[UILabel alloc] init];
    userName.text = @"账号";
    [self.view addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.userNameTF);
        make.right.mas_equalTo(self.userNameTF.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    self.passwordTF = [[UITextField alloc] init];
    self.passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTF.placeholder = @"请输入密码";
    [self.view addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTF.mas_bottom).offset(15);
        make.size.mas_equalTo(self.userNameTF);
        make.left.mas_equalTo(SCREEN_WIDTH*0.3);
    }];
    
    UILabel *password = [[UILabel alloc] init];
    password.text = @"密码";
    [self.view addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordTF);
        make.right.mas_equalTo(self.passwordTF.mas_left).offset(-10);
        make.size.mas_equalTo(userName);
    }];
    
    self.checkPasswordTF = [[UITextField alloc] init];
    self.checkPasswordTF.borderStyle = UITextBorderStyleRoundedRect;
    self.checkPasswordTF.placeholder = @"请再次输入密码";
    [self.view addSubview:self.checkPasswordTF];
    [self.checkPasswordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(15);
        make.size.mas_equalTo(self.passwordTF);
        make.left.mas_equalTo(SCREEN_WIDTH*0.3);
    }];
    
    UILabel *checkPassword = [[UILabel alloc] init];
    checkPassword.text = @"确认密码";
    [self.view addSubview:checkPassword];
    [checkPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.checkPasswordTF);
        make.right.mas_equalTo(self.checkPasswordTF.mas_left).offset(-10);
        make.size.mas_equalTo(userName);
    }];
    
    self.ageTF = [[UITextField alloc] init];
    self.ageTF.borderStyle = UITextBorderStyleRoundedRect;
    self.ageTF.placeholder = @"请输入年龄(选填)";
    [self.view addSubview:self.ageTF];
    [self.ageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.checkPasswordTF.mas_bottom).offset(15);
        make.size.mas_equalTo(self.checkPasswordTF);
        make.left.mas_equalTo(SCREEN_WIDTH*0.3);
    }];
    
    UILabel *age = [[UILabel alloc] init];
    age.text = @"年龄";
    [self.view addSubview:age];
    [age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ageTF);
        make.right.mas_equalTo(self.ageTF.mas_left).offset(-10);
        make.size.mas_equalTo(userName);
    }];
    
    self.registerButton = [[UIButton alloc] init];
    [self.registerButton setTitle:@"reginster" forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(reginster) forControlEvents:UIControlEventTouchUpInside];
    self.registerButton.layer.cornerRadius = 6;
    self.registerButton.clipsToBounds = YES;
    self.registerButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 45));
        make.bottom.mas_equalTo(-100);
    }];
}

- (void)reginster{
    UserModel *userModel = [[UserModel alloc] init];
    userModel.userName = self.userNameTF.text;
    userModel.passWord = self.passwordTF.text;
    userModel.age = self.ageTF.text;
    userModel.creatTime = [self getCurrentTime];
    
    if ([self.userNameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""]) {
        [MBProgressHUD showMsg:@"请先填写账号和密码"];
        return;
    }
    
    if (![self.passwordTF.text isEqualToString:self.checkPasswordTF.text]) {
        [MBProgressHUD showMsg:@"密码输入有误"];
        return;
    }
    
    [MBProgressHUD showLoadingWithMsg:@"正在注册..."];
    [[MXiCloudManager shareInstance] mx_addCloudDataWithZoneTypeisPublic:YES recordName:userModel.userName dataModel:userModel finishBlock:^(BOOL isSuccess, NSString *detailString) {
        
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isSuccess) {
                [MBProgressHUD showMsg:detailString];
            }else{
                [MBProgressHUD showMsg:detailString];
            }
        });
    }];
}

- (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    return [formatter stringFromDate:[NSDate date]];
}

//通过时间戳获取时间
- (NSString *)getStringWith:(NSInteger)timeTmap{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeTmap/1000];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

//获取当前时间戳
- (NSString *)getCurrentIntger{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.checkPasswordTF resignFirstResponder];
    [self.ageTF resignFirstResponder];
}

@end

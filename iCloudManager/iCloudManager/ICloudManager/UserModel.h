//
//  UserModel.h
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, assign) NSInteger  age;
@property (nonatomic, copy) NSString *creatTime;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *userName;
@end

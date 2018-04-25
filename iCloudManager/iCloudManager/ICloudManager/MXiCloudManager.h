//
//  MXiCloudManager.h
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>
#import "UserModel.h"
#import "MBProgressHUD+Ex.h"

@interface MXiCloudManager : NSObject

+ (instancetype)shareInstance;

//检查icloud是否可用
- (BOOL)mx_iCloudIsEnable;

//添加新的数据
- (void)mx_addCloudDataWithZoneType:(BOOL)isPublic
                         recordName:(NSString *)recordName
                          dataModel:(UserModel *)userModel
                        finishBlock:(void(^)(BOOL isSuccess, NSString *detailString))finishBlock;


@end

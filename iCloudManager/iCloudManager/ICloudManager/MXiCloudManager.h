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
- (void)mx_addCloudDataWithZoneTypeisPublic:(BOOL)isPublic
                         recordName:(NSString *)recordName
                          dataModel:(UserModel *)userModel
                        finishBlock:(void(^)(BOOL isSuccess, NSString *detailString))finishBlock;

//删除记录
-(void)mx_deleteCloudDataWithZoneTypeisPublic:(BOOL)isPublic
                               withRecordName:(NSString *)recordName
                                  finishBlock:(void(^)(BOOL isSuccess, NSString *detailString))finishBlock;

//更新一条记录 首先要查找出这一条  然后再对它进行修改
-(void)mx_updateCloudDataWithZoneTypeisPublic:(BOOL)isPublic
                                   recordName:(NSString *)recordName
                                    userModel:(UserModel *)userModel
                                  finishBlock:(void(^)(BOOL isSuccess, NSString *detailString))finishBlock;

//查询单条数据
- (void)mx_fetchICloudDataWithZoneTypeisPublic:(BOOL)isPublic
                                    recordName:(NSString *)recordName
                                   finishBlock:(void(^)(UserModel* userModel,NSError *error))finishBlock;

//查询所有数据
- (NSMutableArray *)mx_fetchICloudAllDataWithZoneTypeisPublic:(BOOL)isPublic;
@end

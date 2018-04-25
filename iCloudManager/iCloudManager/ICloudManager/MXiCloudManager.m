//
//  MXiCloudManager.m
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

//数据模型
#define kDataModel @"dataModel"

#define kContainerID @"iCloud.DataTest"

#import "MXiCloudManager.h"

@implementation MXiCloudManager

+ (instancetype)shareInstance{
    static MXiCloudManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MXiCloudManager alloc] init];
    });
    return manager;
}

//检查icloud是否可用
- (BOOL)mx_iCloudIsEnable{
     id cloudUrl = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:kContainerID];
    if (cloudUrl == nil) {
        return NO;
    }else{
        return YES;
    }
}

//添加新的数据
- (void)mx_addCloudDataWithZoneType:(BOOL)isPublic recordName:(NSString *)recordName dataModel:(UserModel *)userModel finishBlock:(void(^)(BOOL isSuccess, NSString *detailString))finishBlock{
    CKContainer *containter = [CKContainer defaultContainer];
    CKDatabase *dataBase;
    if (isPublic) {
        dataBase = containter.publicCloudDatabase;
    }else{
        dataBase = containter.privateCloudDatabase;
    }
    
    CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:kDataModel];
    CKRecord *record = [[CKRecord alloc] initWithRecordType:kDataModel recordID:recordID];
    [record setObject:[NSString stringWithFormat:@"%ld",(long)userModel.age] forKey:@"age"];
    [record setObject:userModel.userName forKey:@"userName"];
    [record setObject:userModel.passWord forKey:@"passWord"];
    [record setObject:userModel.creatTime forKey:@"creatTime"];

    [dataBase saveRecord:record completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            finishBlock(YES,@"数据保存成功");
        }else{
            finishBlock(NO,[NSString stringWithFormat:@"数据储存失败 : %@",error.localizedDescription]);
        }
    }];
}

@end

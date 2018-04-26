//
//  MXiCloudManager.m
//  iCloudManager
//
//  Created by rbt-Macmini on 2018/4/25.
//  Copyright © 2018年 Mr.Xiao. All rights reserved.
//

//数据模型
#define kDataModel @"UserRegisterData"

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
    NSLog(@"%@",cloudUrl);
    if (cloudUrl == nil) {
        return NO;
    }else{
        return YES;
    }
}

//添加新的数据
- (void)mx_addCloudDataWithZoneTypeisPublic:(BOOL)isPublic recordName:(NSString *)recordName dataModel:(UserModel *)userModel finishBlock:(void(^)(BOOL isSuccess, NSString *detailString))finishBlock{
//这个地方要注意 同样要选对容器ID  不然会默认储存到默认的容器中 单单选中Capabilties 的ID 还是不能储存进特定的容器中
//    CKContainer *containter = [CKContainer defaultContainer];
    
    
    CKContainer *containter = [CKContainer containerWithIdentifier:kContainerID];
    CKDatabase *dataBase;
    if (isPublic) {
        dataBase = containter.publicCloudDatabase;
    }else{
        dataBase = containter.privateCloudDatabase;
    }
    
    CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:recordName];
    CKRecord *record = [[CKRecord alloc] initWithRecordType:kDataModel recordID:recordID];
    [record setObject:userModel.age forKey:@"age"];
    [record setObject:userModel.userName forKey:@"userName"];
    [record setObject:userModel.passWord forKey:@"passWord"];
    [record setObject:userModel.creatTime forKey:@"creatTime"];

    [dataBase saveRecord:record completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            finishBlock(YES,@"注册成功");
        }else{
            finishBlock(NO,@"注册失败");
            NSLog(@"数据储存错误 ：%@",error.localizedDescription);
        }
    }];
}

//删除记录
-(void)mx_deleteCloudDataWithZoneTypeisPublic:(BOOL)isPublic withRecordName:(NSString *)recordName finishBlock:(void(^)(BOOL isSuccess, NSString *detailString))finishBlock
{
    //获得指定的ID
    CKRecordID *recordID = [[CKRecordID alloc]initWithRecordName:recordName];
    
    //获得容器
    CKContainer *containter = [CKContainer containerWithIdentifier:kContainerID];
    
    //获得数据的类型 是公有还是私有
    CKDatabase *database;
    if (isPublic) {
        database = containter.publicCloudDatabase;
    }
    else
    {
        database = containter.privateCloudDatabase;
    }
    
    //    __weak typeof(self)weakSelf = self;
    [database deleteRecordWithID:recordID completionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
        if (!error) {
            finishBlock(YES,@"删除成功");
        }else{
            finishBlock(NO,@"删除失败");
            NSLog(@"数据删除错误 ：%@",error.localizedDescription);
        }
    }];
    
}

//更新一条记录 首先要查找出这一条  然后再对它进行修改
-(void)mx_updateCloudDataWithZoneTypeisPublic:(BOOL)isPublic recordName:(NSString *)recordName
                                    userModel:(UserModel *)userModel finishBlock:(void(^)(BOOL isSuccess, NSString *detailString))finishBlock
{
    //获得指定的ID
    CKRecordID *recordID = [[CKRecordID alloc]initWithRecordName:recordName];
    
    //获得容器
    CKContainer *containter = [CKContainer containerWithIdentifier:kContainerID];
    
    //获得数据的类型 是公有还是私有
    CKDatabase *database;
    if (isPublic) {
        database = containter.publicCloudDatabase;
    }
    else
    {
        database = containter.privateCloudDatabase;
    }
    
    //    __weak typeof(self)weakSelf = self;
    //查找操作
    [database fetchRecordWithID:recordID completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            [record setObject:userModel.age forKey:@"age"];
            [record setObject:userModel.userName forKey:@"userName"];
            [record setObject:userModel.passWord forKey:@"passWord"];
            [record setObject:userModel.creatTime forKey:@"creatTime"];
            
            [database saveRecord:record completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
                if (!error) {
                    finishBlock(YES,@"修改成功");
                }else{
                    finishBlock(NO,@"修改失败");
                    NSLog(@"数据修改失败 ：%@",error.localizedDescription);
                }
            }];
        }
    }];
}

//查询单条数据
- (void)mx_fetchICloudDataWithZoneTypeisPublic:(BOOL)isPublic recordName:(NSString *)recordName finishBlock:(void(^)(UserModel* userModel,NSError *error))finishBlock{
    CKContainer *containter = [CKContainer containerWithIdentifier:kContainerID];
    CKDatabase *dataBase;
    if (isPublic) {
        dataBase = containter.publicCloudDatabase;
    }else{
        dataBase = containter.privateCloudDatabase;
    }
    
    CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:recordName];
    
    UserModel *userModel = [[UserModel alloc] init];
    
    [dataBase fetchRecordWithID:recordID completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%@",record);
            userModel.userName = record[@"userName"];
            userModel.passWord = record[@"passWord"];
            userModel.age = record[@"age"];
            userModel.creatTime = record[@"creatTime"];
            finishBlock(userModel,nil);
        }else{
            finishBlock(nil,error);
            NSLog(@"数据查询错误 ：%@",error.localizedDescription);
        }
    }];
}


//查询所有数据
- (NSMutableArray *)mx_fetchICloudAllDataWithZoneTypeisPublic:(BOOL)isPublic{
    NSMutableArray *array = [NSMutableArray array];
    CKContainer *containter = [CKContainer containerWithIdentifier:kContainerID];
    CKDatabase *dataBase;
    if (isPublic) {
        dataBase = containter.publicCloudDatabase;
    }else{
        dataBase = containter.privateCloudDatabase;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:kDataModel predicate:predicate];
    
    [dataBase performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        if (!error) {
            [array addObject:results];
        }else{
            NSLog(@"数据查询错误 ：%@",error.localizedDescription);
        }
            
    }];
    return array;
}
@end

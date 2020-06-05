//
//  SHContact.m
//  SHLivePhoto
//
//  Created by fankangpeng on 2020/6/5.
//  Copyright © 2020 sw_voip. All rights reserved.
//

#import "SHContact.h"




@interface SHContact ()<UIAlertViewDelegate>

@property (nonatomic ,strong) NSArray *allContact;//所有的联系人
@end

@implementation SHContact

+ (instancetype)shareInstall{
    static SHContact *contact;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        contact = [SHContact new];
    });return contact;
}

+ (NSInteger)authContact{
    return [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
}
+ (NSArray *)getAllContact{
    return [SHContact queryContactWithName:nil];
}



+ (NSArray *)queryContactWithName:(NSString *)name{
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] != CNAuthorizationStatusAuthorized) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        NSString *tips = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-通讯录“选项中，允许%@访问你的通讯录。",app_Name?:@""];
        [[[UIAlertView alloc] initWithTitle:@"提示" message:tips delegate:[SHContact shareInstall] cancelButtonTitle:@"取消" otherButtonTitles:@"去授权", nil] show];
        return nil;
    }

    CNContactStore *store = [[CNContactStore alloc] init];
    // 提取数据 （keysToFetch:@[CNContactGivenNameKey]是设置提取联系人的哪些数据）
    NSArray *contact = [store unifiedContactsMatchingPredicate:name? [CNContact predicateForContactsMatchingName:name]:nil keysToFetch:@[CNContactGivenNameKey,
                                                                                                                                         CNContactFamilyNameKey,
                                                                                                                                         CNContactImageDataKey,
                                                                                                                                         CNContactUrlAddressesKey,
                                                                                                                                         CNContactNicknameKey,
                                                                                                                                         CNContactJobTitleKey,
                                                                                                                                         CNContactPhoneNumbersKey,
                                                                                                                                         CNContactBirthdayKey,
                                                                                                                                         CNContactEmailAddressesKey,
                                                                                                                                         CNContactOrganizationNameKey] error:nil];
    [SHContact shareInstall].allContact = contact;
    return contact;
}



+ (BOOL)updateContact:(CNMutableContact *)contact{
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest updateContact:contact];
    // 重新写入
    CNContactStore *store = [[CNContactStore alloc] init];
    NSError *error;
    [store executeSaveRequest:saveRequest error:&error];
    return error ? NO:YES;
}

/**
 *  删除联系人
 *
 *  @param contact 被删除的联系人
 */
+ (BOOL)deleteContact:(CNMutableContact *)contact{
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest deleteContact:contact];
    // 写入操作
    CNContactStore *store = [[CNContactStore alloc] init];
    NSError *error;
    [store executeSaveRequest:saveRequest error:&error];
    return error ? NO:YES;
}

/**
 *  添加联系人
 *
 *  @param contact 联系人
 */
+ (BOOL)addContact:(CNMutableContact *)contact{
    // 创建联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    // 写入联系人
    CNContactStore *store = [[CNContactStore alloc] init];
    NSError *error;
    [store executeSaveRequest:saveRequest error:&error];
    return error ? NO:YES;
}

#pragma mark  - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
@end

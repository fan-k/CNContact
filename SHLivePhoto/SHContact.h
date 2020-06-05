//
//  SHContact.h
//  SHLivePhoto
//
//  Created by fankangpeng on 2020/6/5.
//  Copyright © 2020 sw_voip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
NS_ASSUME_NONNULL_BEGIN

/**通讯录iOS9以上
 *  需在plist中配置 Privacy - Contacts Usage Description
 */
@interface SHContact : NSObject

/*
 *  通讯录授权
 *  @return 授权状态
 */
+ (NSInteger)authContact;


/*
 *  读取所有通讯录
 *  @return array
 */
+ (NSArray *)getAllContact;


/*
 *  查询包含某个名字的通讯录
 *  @param name 名字
 *  @return array
 */
+ (NSArray *)queryContactWithName:(NSString *)name;

/**
 *  更新联系人
 *
 *  @param contact 被更新的联系人
 *  @return 更新结果
 */
+ (BOOL)updateContact:(CNMutableContact *)contact;
/**
 *  删除联系人
 *
 *  @param contact 被删除的联系人
 *  @return 删除结果
 */
+ (BOOL)deleteContact:(CNMutableContact *)contact;
/**
 *  添加联系人
 *
 *  @param contact 联系人
 *  @return 添加结果
 */
+ (BOOL)addContact:(CNMutableContact *)contact;

@end

NS_ASSUME_NONNULL_END

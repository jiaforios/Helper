//
//  NSString+Extension.h
//  Saftop
//
//  Created by AG_TigerNong on 16/4/27.
//  Copyright © 2016年 Saftop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  判断输入的手机号码
 */
+ (BOOL)matchPhoneNumber:(NSString *)phone;

/**
 *  判断邮箱
 */
+ (BOOL)matchEmail:(NSString *)email;
/**
 *  判断身份证
 */
+ (BOOL)matchIndentiferCard:(NSString *)IDCard;

/**
 *  获取文件的路径
 */
+ (NSString *)dirFilePath;

+ (NSString *)sqliteFileURL;

/**
 *  判断输入的字符串中是否含有emoji表情
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;


+ (NSString *)stringWithOutMiddleline:(NSString *)string;

+ (NSString *)smartTimeWithOriginalTime:(NSString *)originalTime;

+ (NSString *)smartTimeWithoutHMSWithOriginalTime:(NSString *)originalTime;

//判断时间是哪一天
+ (NSString *)dateWithTime:(NSString *)time;


//没有秒的时间
+ (NSString *)smartTimeWithSecondWithOriginalTime:(NSString *)originalTime;

+ (NSString *)currentTime;

+ (NSString *)currentWithoutSecondTime;

//比较两个时间
+ (BOOL)compareWithoutSecondStartTime:(NSString *)startTime withEndTime:(NSString *)endTime;

+ (BOOL)compareStartTime:(NSString *)startTime withEndTime:(NSString *)endTime;

@end

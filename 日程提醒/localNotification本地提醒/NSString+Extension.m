//
//  NSString+Extension.m
//  Saftop
//
//  Created by AG_TigerNong on 16/4/27.
//  Copyright © 2016年 Saftop. All rights reserved.
//

#import "NSString+Extension.h"
#import "NSDate+Extension.h"

@implementation NSString (Extension)


+ (NSString *)cacheURL {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)smartTimeWithOriginalTime:(NSString *)originalTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *originalDate = [formatter dateFromString:originalTime];
    if (originalDate.isThisYear) { // 今年
        if (originalDate.isToday) { // 今天
            
            [formatter setDateFormat:@"HH:mm"];
            return [formatter stringFromDate:originalDate];
            
        } else if (originalDate.isYesterday) { // 昨天
            
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:originalDate];
            
        } else { // 其他
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:originalDate];
        }
    } else { // 非今年
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        return [formatter stringFromDate:originalDate];
    }
}

+ (NSString *)smartTimeWithoutHMSWithOriginalTime:(NSString *)originalTime {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *originalDate = [formatter dateFromString:originalTime];
    if (originalDate.isThisYear) { // 今年
        if (originalDate.isToday) { // 今天
            
            [formatter setDateFormat:@"HH:mm"];
            return [formatter stringFromDate:originalDate];
            
        } else if (originalDate.isYesterday) { // 昨天
            
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:originalDate];
            
        } else { // 其他
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:originalDate];
        }
    } else { // 非今年
        [formatter setDateFormat:@"yyyy/MM/dd"];
        return [formatter stringFromDate:originalDate];
    }
}

+ (NSString *)smartTimeWithSecondWithOriginalTime:(NSString *)originalTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *originalDate = [formatter dateFromString:originalTime];
    if (originalDate.isThisYear) { // 今年
        if (originalDate.isToday) { // 今天
            
            [formatter setDateFormat:@"今日 HH:mm"];
            return [formatter stringFromDate:originalDate];
            
        } else if (originalDate.isYesterday) { // 昨天
            
            formatter.dateFormat = @"昨日 HH:mm";
            return [formatter stringFromDate:originalDate];
            
        }else if (originalDate.isTomorrow) { // 明天
            formatter.dateFormat = @"明日 HH:mm";
            return [formatter stringFromDate:originalDate];
            
        } else { // 其他
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:originalDate];
        }
    } else { // 非今年
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        return [formatter stringFromDate:originalDate];
    }
}




+ (NSString *)stringWithOutMiddleline:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (BOOL)matchPhoneNumber:(NSString *)phone{
    if (phone.length < 11 || phone.length > 11) {
        
        return NO;
    }else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:phone];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:phone];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:phone];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    
    }
}


+ (BOOL)matchEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)matchIndentiferCard:(NSString *)IDCard{
    
    IDCard = [IDCard stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if (IDCard.length != 18) {
        return NO;
    }
    
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    
    NSString *leapMmdd = @"0229";
    
    NSString *year = @"(19|20)[0-9]{2}";
    
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
     NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![regexTest evaluateWithObject:IDCard]) {
        return NO;
    }
    
    int summary = ([IDCard substringWithRange:NSMakeRange(0,1)].intValue + [IDCard substringWithRange:NSMakeRange(10,1)].intValue) * 7  + ([IDCard substringWithRange:NSMakeRange(1,1)].intValue + [IDCard substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([IDCard substringWithRange:NSMakeRange(2,1)].intValue + [IDCard substringWithRange:NSMakeRange(12,1)].intValue) * 10 + ([IDCard substringWithRange:NSMakeRange(3,1)].intValue + [IDCard substringWithRange:NSMakeRange(13,1)].intValue) * 5 + ([IDCard substringWithRange:NSMakeRange(4,1)].intValue + [IDCard substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([IDCard substringWithRange:NSMakeRange(5,1)].intValue + [IDCard substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([IDCard substringWithRange:NSMakeRange(6,1)].intValue + [IDCard substringWithRange:NSMakeRange(16,1)].intValue) *2 + [IDCard substringWithRange:NSMakeRange(7,1)].intValue *1 + [IDCard substringWithRange:NSMakeRange(8,1)].intValue *6 + [IDCard substringWithRange:NSMakeRange(9,1)].intValue *3;
    
    NSInteger remainder = summary % 11;
    
    NSString *checkBit = @"";
    
    NSString *checkString = @"10X98765432";
    
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    
    return [checkBit isEqualToString:[[IDCard substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (NSString *)dirFilePath{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePathDir = [cachesPath stringByAppendingPathComponent:@"myFriend"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    [fileManager createDirectoryAtPath:filePathDir withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (!error) {
        return filePathDir;
    }else{
        return cachesPath;
    }
}

+  (NSString *)sqliteFileURL {
    NSString *sqliteName = [NSString stringWithFormat:@"myFriend.sqlite"];
    return [[NSString dirFilePath] stringByAppendingPathComponent:sqliteName];
}

+ (NSString *)currentTime{
    NSDate *currentData = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *currentT = [dateFormatter stringFromDate:currentData];
    return currentT;
}

+ (NSString *)currentWithoutSecondTime{
    NSDate *currentData = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSString *currentT = [dateFormatter stringFromDate:currentData];
    return currentT;
}


+ (NSString *)dateWithTime:(NSString *)time{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *originalDate = [formatter dateFromString:time];
    
    if (originalDate.isThisYear) { // 今年
        if (originalDate.isToday) { // 今天
            return @"今日";
            
        } else if (originalDate.isTomorrow) { // 昨天
            return @"明日";
            
        } else { // 其他
            return @"将来";
        }
    } else { // 非今年
         return @"将来";
    }
}

+ (BOOL)compareWithoutSecondStartTime:(NSString *)startTime withEndTime:(NSString *)endTime{
    //获取预约时间到1970-01-01 00：00：00的秒数
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSDate *dateStart = [dateFormatter dateFromString:startTime];
    NSTimeInterval startInterval = [dateStart timeIntervalSince1970];
    
    NSDate *dateEnd = [dateFormatter dateFromString:endTime];
    NSTimeInterval endInterval = [dateEnd timeIntervalSince1970];
    
    if (startInterval < endInterval) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)compareStartTime:(NSString *)startTime withEndTime:(NSString *)endTime{
    //获取预约时间到1970-01-01 00：00：00的秒数
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *dateStart = [dateFormatter dateFromString:startTime];
    NSTimeInterval startInterval = [dateStart timeIntervalSince1970];
    
    NSDate *dateEnd = [dateFormatter dateFromString:endTime];
    NSTimeInterval endInterval = [dateEnd timeIntervalSince1970];
    
    if (startInterval < endInterval) {
        return YES;
    }else{
        return NO;
    }
}


@end

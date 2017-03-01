//
//  NSDate+Extension.h
//  Saftop
//
//  Created by neo on 16/8/27.
//  Copyright © 2016年 Saftop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSDateComponents *)deltaFrom:(NSDate *)from;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isTomorrow;
@end

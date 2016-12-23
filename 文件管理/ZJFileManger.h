//
//  ZJFileManger.h
//  Function Model
//
//  Created by foscom on 16/7/12.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZJFileManger : NSObject
+ (NSString *)homePath;  // 根目录
+ (NSString *)appPath;  // 程序路径
+ (NSString *)documentPath;  // 文件管理路径
+ (NSString *)liberaryPath;  // 配置信息路径
+ (NSString *)libprePath;  // 配置偏好路径
+ (NSString *)libCachePath;  // 配置缓存路径
+ (NSString *)tempPath;  // 程序缓存路径  ，程序结束会清除

+ (BOOL)haveDirectoryPath:(NSString *)path;
+ (BOOL)haveFilePath:(NSString *)path;

+ (NSString *)createDirectoryPath:(NSString *)path;  // 创建目录路径
+ (NSString *)cerateFilePath:(NSString *)patch WithContentData:(NSData *)data; // 创建文件路径
+ (NSArray *)SubFilesInDirectoty:(NSString *)file; // 文件夹下文件数量
+ (CGFloat)diskOfAllSizeMBytes; // 磁盘大小
+ (CGFloat)diskOfFreeSizeMBytes; // 磁盘可用空间大小
+ (long long)fileSizeAtPath:(NSString *)filePath; // 获取文件大小
+ (long long)folderSizeAtPath:(NSString *)folderPath; //获取文件夹下所有文件的大小



@end

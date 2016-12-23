//
//  ZJFileManger.m
//  Function Model
//
//  Created by foscom on 16/7/12.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import "ZJFileManger.h"
@implementation ZJFileManger
+ (NSString *)homePath
{
    return NSHomeDirectory();
}

+ (NSString *)appPath
{
    return NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)documentPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}
+ (NSString *)liberaryPath
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}
+ (NSString *)libprePath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/Preference"];
}
+ (NSString *)libCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/Cache"];
}

+ (NSString *)tempPath
{
    return [NSHomeDirectory() stringByAppendingString:@"/tmp"];
}

+ (BOOL)haveDirectoryPath:(NSString *)path
{
    BOOL isdirectory = YES;
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isdirectory];
}

+ (BOOL)haveFilePath:(NSString *)path
{
    BOOL isdirectory = NO;
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isdirectory];
}
+ (NSString *)createDirectoryPath:(NSString *)path
{
    if ([ZJFileManger haveDirectoryPath:path]) {
        return path;
    }else
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
        return path;
    }
}

+ (NSString *)cerateFilePath:(NSString *)patch WithContentData:(NSData *)data
{
    
    if ([ZJFileManger haveFilePath:patch]) {
        return patch;
    }else
    {
        [[NSFileManager defaultManager] createFileAtPath:patch contents:data attributes:nil];
        return patch;
    }
}

+ (NSArray *)SubFilesInDirectoty:(NSString *)file
{
    //    NSArray *subFileArr = [[NSFileManager defaultManager] subpathsAtPath:file]; // 能够遍历到当前路径下的全部路径，及子路径
    //
    //    NSArray *subdirectoryArr = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:file error:nil];
    
    NSError *error;
    
    NSArray*  subdirectoryArr =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:file error:&error]; // 只遍历当前目录下的内容，不遍历 子文件夹的内容
    if (error) {
        
        NSLog(@"___%s___查询子目录结果失败",__func__);
        return nil;
    }
    return subdirectoryArr;
    
}


//磁盘总空间
+ (CGFloat)diskOfAllSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

//磁盘可用空间
+ (CGFloat)diskOfFreeSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

//获取文件大小
+ (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) return 0;
    return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
}

//获取文件夹下所有文件的大小
+ (long long)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *filesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folerSize = 0;
    while ((fileName = [filesEnumerator nextObject]) != nil) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        folerSize += [self fileSizeAtPath:filePath];
    }
    return folerSize;
}

@end

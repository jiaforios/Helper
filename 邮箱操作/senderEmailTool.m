//
//  senderEmailTool.m
//  指纹识别
//
//  Created by foscom on 16/4/1.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import "senderEmailTool.h"

@interface senderEmailTool ()

@property(nonatomic,strong)UIViewController *emailInvc;

@end

@implementation senderEmailTool

+ (id)shareEmailTool
{
    
    static senderEmailTool *tool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tool = [[senderEmailTool alloc] init];
        
    });
    
    return tool;
    
}

- (void)setUpEmailWithtoRecipients:(NSArray *)toRecipients
                   andccRecipients:(NSArray *)ccRecipients
                  andbccRecipients:(NSArray *)bccRecipients
                        andSubject:(NSString *)subject
                      andEmailBody:(NSString *)emailbody
                   andAdjunctPatch:(NSArray *)filePath
                       andfileName:(NSArray *)fileName
                              inVc:(UIViewController *)vc
{
    _emailInvc = vc;
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    if (picker == nil) {
        NSLog(@"设备还没添加邮箱账户");
        return;
    }
    picker.mailComposeDelegate = self;
    [picker setSubject:subject];
    
    [picker setToRecipients:toRecipients];
    [picker setCcRecipients:ccRecipients];
    [picker setBccRecipients:bccRecipients];
    
    NSFileManager *file = [NSFileManager defaultManager];
    
    
    for (int i=0; i<filePath.count; i++)
    {
        if (![file fileExistsAtPath:filePath[i]])
        {
            NSLog(@"Email-Sender 附件%d 文件路径不存在 ",i);
            continue;
        }
        
        NSData *adjunctData = [NSData dataWithContentsOfFile:filePath[i]];
        
        [picker addAttachmentData:adjunctData mimeType:@""
                         fileName:(fileName[i] == nil)?filePath[i]:fileName[i]];
    }
    
    
    NSString *emailBody = emailbody;
    
    [picker setMessageBody:emailBody isHTML:NO];
    
    
    [vc presentViewController:picker animated:YES completion:nil];
    
    
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: //取消
            NSLog(@"MFMailComposeResultCancelled-取消");
            break;
        case MFMailComposeResultSaved: // 保存
            NSLog(@"MFMailComposeResultSaved-保存邮件");
            break;
        case MFMailComposeResultSent: // 发送
            NSLog(@"MFMailComposeResultSent-发送邮件");
            break;
        case MFMailComposeResultFailed: // 尝试保存或发送邮件失败
            NSLog(@"MFMailComposeResultFailed: %@...",[error localizedDescription]);
            break;
    }
    
    // 关闭邮件发送视图
    [_emailInvc dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end






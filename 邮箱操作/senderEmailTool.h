//
//  senderEmailTool.h
//  指纹识别
//
//  Created by foscom on 16/4/1.
//  Copyright © 2016年 foscam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>


@interface senderEmailTool : NSObject<MFMailComposeViewControllerDelegate>

+ (id)shareEmailTool;

- (void)setUpEmailWithtoRecipients:(NSArray * /* 收件人 */)toRecipients
                   andccRecipients:(NSArray * /* 抄送人 */)ccRecipients
                  andbccRecipients:(NSArray *  /* 密送人 不支持QQ邮箱*/)bccRecipients
                        andSubject:(NSString * /*  主题 */)subject
                      andEmailBody:(NSString * /* 标题 */)emailbody
                   andAdjunctPatch:(NSArray * /* 文件路径 */)filePath
                       andfileName:(NSArray * /* 文件名和路径对应 */)fileName
                              inVc:(UIViewController * /* 当前控制器 */)vc;



@end

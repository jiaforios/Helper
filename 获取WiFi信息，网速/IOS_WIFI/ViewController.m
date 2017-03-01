//
//  ViewController.m
//  IOS_WIFI
//
//  Created by mac on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "HYDWifiModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取wifi信息
    NSDictionary *WIFImessage = [HYDWifiModel fetchSSIDInfo];
    //检测手机网络速度
    NSMutableDictionary *WIFIspeed = [HYDWifiModel getDataCounters];
    
    NSLog(@"获取wifi信息 = %@ ------------- 检测手机网络速度 = %@",WIFImessage,WIFIspeed);
}


//- (NSArray *)getDataCounters
//{
//    BOOL   success;
//    struct ifaddrs *addrs;
//    const struct ifaddrs *cursor;
//    const struct if_data *networkStatisc;
//    
//    int WiFiSent = 0;
//    int WiFiReceived = 0;
//    int WWANSent = 0;
//    int WWANReceived = 0;
//    
//    NSString *name=[[NSString alloc]init];
//    
//    success = getifaddrs(&addrs) == 0;
//    if (success)
//    {
//        cursor = addrs;
//        while (cursor != NULL)
//        {
//            
//            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
////            NSLog(@"ifa_name %s == %@n", cursor->ifa_name,name);
//            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
//            
//            if (cursor->ifa_addr->sa_family == AF_LINK)
//            {
//                if ([name hasPrefix:@"en"])
//                {
//                    networkStatisc = (const struct if_data *) cursor->ifa_data;
//                    WiFiSent+=networkStatisc->ifi_obytes;
//                    WiFiReceived+=networkStatisc->ifi_ibytes;
//                    // NSLog(@"WiFiSent %d ==%d",WiFiSent,networkStatisc->ifi_obytes);
//                    //NSLog(@"WiFiReceived %d ==%d",WiFiReceived,networkStatisc->ifi_ibytes);
//                }
//                
//                if ([name hasPrefix:@"pdp_ip"])
//                {
//                    networkStatisc = (const struct if_data *) cursor->ifa_data;
//                    WWANSent+=networkStatisc->ifi_obytes;
//                    WWANReceived+=networkStatisc->ifi_ibytes;
//                    // NSLog(@"WWANSent %d ==%d",WWANSent,networkStatisc->ifi_obytes);
//                    //NSLog(@"WWANReceived %d ==%d",WWANReceived,networkStatisc->ifi_ibytes);
//                    
//                }
//            }
//            
//            cursor = cursor->ifa_next;
//        }
//        
//        freeifaddrs(addrs);
//    }
//    
//    NSLog(@"nwifiSend:%.2f MBnwifiReceived:%.2f MBn wwansend:%.2f MBn wwanreceived:%.2f MBn",WiFiSent/1024.0/1024.0,WiFiReceived/1024.0/1024.0,WWANSent/1024.0/1024.0,WWANReceived/1024.0/1024.0);
//    
//    self.label.text = [NSString stringWithFormat:@"nwifiSend:%.2f MBnwifiReceived:%.2f MBn wwansend:%.2f MBn wwanreceived:%.2f MBn",WiFiSent/1024.0/1024.0,WiFiReceived/1024.0/1024.0,WWANSent/1024.0/1024.0,WWANReceived/1024.0/1024.0];
//    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent], [NSNumber numberWithInt:WiFiReceived],[NSNumber numberWithInt:WWANSent],[NSNumber numberWithInt:WWANReceived], nil];
//}


@end



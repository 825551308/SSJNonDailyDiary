//
//  AppDelegate+ShareSDK.m
//  SSJNonDailyDiary
//
//  Created by 金汕汕 on 2017/9/1.
//  Copyright © 2017年 ccs. All rights reserved.
//

#import "AppDelegate+ShareSDK.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//微信SDK头文件
#import "WXApi.h"


@implementation AppDelegate (ShareSDK)
- (BOOL)shareSDK_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    /**初始化ShareSDK应用
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeMail),
                                        @(SSDKPlatformTypeWechat),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxa58e5b0a76b97140"
                                       appSecret:@"50db5f27daea85d6175faa33c78da2fd"];
                 break;
             default:
                 break;
         }
     }];
    return YES;
}
@end

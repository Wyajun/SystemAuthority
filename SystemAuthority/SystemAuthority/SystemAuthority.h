//
//  SystemAuthority.h
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/19.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,AuthorityStatus)
{
    /// 未知状态
    SystemAuthorityNone,
    /// 1.尚未表态
    SystemAuthorityWBT = 1 ,
    /// 2.用户拒绝
    SystemAuthorityJJ = 2 ,
    /// 3.用户授权
    SystemAuthoritySQ = 3,
};

@interface SystemAuthority : NSObject
/// 相册是否授权
+(AuthorityStatus)albumAuthority;
/// 相机是否授权
+(AuthorityStatus)cameraAuthority;
/// GPS是否授权
+(AuthorityStatus)GPSAuthority;
/// 通讯录是否授权
+(AuthorityStatus)addressBookAuthority;
/// 麦克风是否授权
+(AuthorityStatus)microphoneAuthority;

@end

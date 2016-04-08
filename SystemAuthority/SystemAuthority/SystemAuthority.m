//
//  SystemAuthority.m
//  jiadao_driver_ios
//
//  Created by 王亚军 on 15/12/19.
//  Copyright © 2015年 jiadao. All rights reserved.
//

#import "SystemAuthority.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#define IOS9 [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0
static NSString *const albumSettingTip = @"照片被禁用，请在设置-隐私中开启";
static NSString *const cameraSettingTip = @"相机被禁用，请在设置-隐私中开启";
@implementation SystemAuthority

+(AuthorityStatus)albumAuthority {
    if (IOS8) {
     PHAuthorizationStatus author = [PHPhotoLibrary authorizationStatus];
        switch (author) {
            case PHAuthorizationStatusRestricted:
            case PHAuthorizationStatusDenied:
                return SystemAuthorityJJ;
                break;
            case PHAuthorizationStatusAuthorized:
                return SystemAuthoritySQ;
                break;
            case PHAuthorizationStatusNotDetermined:
                return SystemAuthorityWBT;
                break;
            default:
                break;
        }
        
        
    }else {
           ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        switch (author) {
            case ALAuthorizationStatusRestricted:
            case ALAuthorizationStatusDenied:
                return SystemAuthorityJJ;
                break;
            case ALAuthorizationStatusAuthorized:
                return SystemAuthoritySQ;
                break;
            case ALAuthorizationStatusNotDetermined:
                return SystemAuthorityWBT;
                break;
            default:
                break;
        }
        
    }
    return SystemAuthorityNone;
}
+(AuthorityStatus)cameraAuthority {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (authStatus) {
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:
            return SystemAuthorityJJ;
            break;
        case AVAuthorizationStatusAuthorized:
            return SystemAuthoritySQ;
            break;
        case AVAuthorizationStatusNotDetermined:
            return SystemAuthorityWBT;
            break;
        default:
            break;
    }
    return SystemAuthorityNone;
}
+(AuthorityStatus)GPSAuthority {
    CLAuthorizationStatus authStatus =  [CLLocationManager authorizationStatus];
    switch (authStatus) {
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            return SystemAuthorityJJ;
            break;
        case kCLAuthorizationStatusNotDetermined:
            return SystemAuthorityWBT;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return SystemAuthoritySQ;
        default:
            break;
    }
}
+(AuthorityStatus)addressBookAuthority {
    if (IOS9) {
       CNAuthorizationStatus authStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (authStatus) {
            case CNAuthorizationStatusRestricted:
            case CNAuthorizationStatusDenied:
                return SystemAuthorityJJ;
                break;
            case CNAuthorizationStatusNotDetermined:
                return SystemAuthorityWBT;
            case CNAuthorizationStatusAuthorized:
                return SystemAuthoritySQ;
            default:
                break;
        }
    }else {
        ABAuthorizationStatus authStatus =  ABAddressBookGetAuthorizationStatus();
        switch (authStatus) {
            case kABAuthorizationStatusDenied:
            case kABAuthorizationStatusRestricted:
                return SystemAuthorityJJ;
                break;
            case kABAuthorizationStatusNotDetermined:
                return SystemAuthorityWBT;
            case kABAuthorizationStatusAuthorized:
                return SystemAuthoritySQ;
            default:
                break;
        }
    }
    
    
}
+(AuthorityStatus)microphoneAuthority {
    __block NSInteger status = SystemAuthorityNone;
    [[AVAudioSession sharedInstance]requestRecordPermission:^(BOOL granted) {
        if (granted) {
            status = SystemAuthoritySQ;
        }else {
            status = SystemAuthorityJJ;
        }
    }];
    return status;
}
@end

//
//  ConfigMacro.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#ifndef ConfigMacro_h
#define ConfigMacro_h

/// AppDelegate
#define ShareAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// Client Info
#define MRC_CLIENT_ID     @"ef5834ea86b53233dc41"
#define MRC_CLIENT_SECRET @"6eea860464609635567d001b1744a052f8568a99"

/// SSKeyChain
#define MRC_SERVICE_NAME @"com.yunschou.ExerciseMVVMRAC"
#define MRC_RAW_LOGIN    @"RawLogin"
#define MRC_PASSWORD     @"Password"
#define MRC_ACCESS_TOKEN @"AccessToken"

/// URL Scheme
#define MRC_URL_SCHEME @"mvvmreactivecocoa"

/// Persistence Directory
#define MRC_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#endif /* ConfigMacro_h */

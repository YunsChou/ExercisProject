//
//  OAuthViewModel.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "OAuthViewModel.h"

@interface OAuthViewModel ()
@property (nonatomic, copy, readwrite) NSString *UUIDString;
@end

@implementation OAuthViewModel

- (void)initialize
{
    [super initialize];
    
    self.title = @"OAuth Login";
    
    CFUUIDRef UUID = CFUUIDCreate(NULL);
    self.UUIDString = CFBridgingRelease(CFUUIDCreateString(NULL, UUID));
    CFRelease(UUID);
    
    NSString *URLString = [[NSString alloc] initWithFormat:@"https://github.com/login/oauth/authorize?client_id=%@&scope=%@&state=%@", MRC_CLIENT_ID, @"user,repo", self.UUIDString];
    NSURL *URL = [NSURL URLWithString:URLString];
    
    self.request = [NSURLRequest requestWithURL:URL];
}

@end

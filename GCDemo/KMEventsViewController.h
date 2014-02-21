//
//  KMEventsViewController.h
//  GCDemo
//
//  Created by nunc03 on 2/21/14.
//  Copyright (c) 2014 Mithun Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleOAuth.h"
#define CLIENT_ID @"936563526095.apps.googleusercontent.com"
#define CLIENT_SECRET @"iSxi22dqJxsRV0dJyfr8WSNH"
@interface KMEventsViewController : UITableViewController<GoogleOAuthDelegate>
@property(nonatomic,strong)GoogleOAuth *aouth;
@property(nonatomic,strong)NSString *calenderId;

@end

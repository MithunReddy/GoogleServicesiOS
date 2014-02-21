//
//  KMViewController.h
//  GCDemo
//
//  Created by nunc03 on 2/20/14.
//  Copyright (c) 2014 Mithun Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleOAuth.h"
#define CLIENT_ID @"936563526095.apps.googleusercontent.com"
#define CLIENT_SECRET @"iSxi22dqJxsRV0dJyfr8WSNH"
@interface KMViewController : UIViewController <GoogleOAuthDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)GoogleOAuth *googleOAuth;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *linkLbl;
@property (weak, nonatomic) IBOutlet UILabel *genderLbl;
- (IBAction)getEvents:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *appointmentTableView;

@end

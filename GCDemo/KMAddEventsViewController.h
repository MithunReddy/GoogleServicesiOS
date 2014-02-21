//
//  KMAddEventsViewController.h
//  GCDemo
//
//  Created by nunc03 on 2/20/14.
//  Copyright (c) 2014 Mithun Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleOAuth.h"
#import "MBProgressHUD.h"
#define CLIENT_ID @"936563526095.apps.googleusercontent.com"
#define CLIENT_SECRET @"iSxi22dqJxsRV0dJyfr8WSNH"

@interface KMAddEventsViewController : UIViewController<GoogleOAuthDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDataSource,UITextFieldDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titletext;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextField *calendarText;
- (IBAction)showDatePicker:(id)sender;
- (IBAction)ShowCalendarPicker:(id)sender;
@property(nonatomic,strong)UIDatePicker *picker;
@property(nonatomic,strong)GoogleOAuth *aouth;
- (IBAction)addEvent:(id)sender;
@property(nonatomic,strong)NSString *eventtxtPost;
@end

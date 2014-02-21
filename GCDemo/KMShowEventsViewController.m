//
//  KMShowEventsViewController.m
//  GCDemo
//
//  Created by nunc03 on 2/20/14.
//  Copyright (c) 2014 Mithun Reddy. All rights reserved.
//

#import "KMShowEventsViewController.h"

@interface KMShowEventsViewController ()

@end

@implementation KMShowEventsViewController
@synthesize googleOAuth;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    googleOAuth = [[GoogleOAuth alloc] initWithFrame:self.view.frame];
    // Set self as the delegate.
    [googleOAuth setGOAuthDelegate:self];
    [googleOAuth authorizeUserWithClienID:CLIENT_ID
                           andClientSecret:CLIENT_SECRET
                             andParentView:self.view
                                 andScopes:[NSArray arrayWithObject:@"https://www.googleapis.com/auth/calendar"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Mark Google auth delegate methods

-(void)responseFromServiceWasReceived:(NSString *)responseJSONAsString andResponseJSONAsData:(NSData *)responseJSONAsData;{
    if ([responseJSONAsString rangeOfString:@"family_name"].location != NSNotFound) {

        
    }
    NSError *error;
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseJSONAsData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&error];
    NSLog(@"Dictionary Calender:%@",dictionary);
}
-(void)authorizationWasSuccessful{
//    [googleOAuth callAPI:@"https://www.googleapis.com/calendar/v3/users/me/calendarList"
//           withHttpMethod:httpMethod_GET
//       postParameterNames:nil
//      postParameterValues:nil];
    [googleOAuth callAPI:@"https://www.googleapis.com/calendar/v3/users/me/calendarList"
          withHttpMethod:httpMethod_GET
      postParameterNames:nil postParameterValues:nil];
}
-(void)errorInResponseWithBody:(NSString *)errorMessage;
{
    NSLog(@"Error message:%@",errorMessage);
}
@end

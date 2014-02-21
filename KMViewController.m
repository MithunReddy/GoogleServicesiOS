//
//  KMViewController.m
//  GCDemo
//
//  Created by nunc03 on 2/20/14.
//  Copyright (c) 2014 Mithun Reddy. All rights reserved.
//

#import "KMViewController.h"
#import "KMEventsViewController.h"
@interface KMViewController ()
{
    NSMutableArray *array;
    NSMutableArray *final;
    KMEventsViewController *eventsVC;
}
@end

@implementation KMViewController
@synthesize googleOAuth;
@synthesize nameLbl;
@synthesize genderLbl;
@synthesize linkLbl;
@synthesize appointmentTableView;
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
   // [self.appointmentTableView setsta]
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    googleOAuth = [[GoogleOAuth alloc] initWithFrame:self.view.frame];
    // Set self as the delegate.
    [googleOAuth setGOAuthDelegate:self];
    [googleOAuth authorizeUserWithClienID:CLIENT_ID
                           andClientSecret:CLIENT_SECRET
                             andParentView:self.view
                                 andScopes:[NSArray arrayWithObjects:@"https://www.googleapis.com/auth/calendar", nil]
     ];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Mark Google auth delegate methods

-(void)responseFromServiceWasReceived:(NSString *)responseJSONAsString andResponseJSONAsData:(NSData *)responseJSONAsData;{

    if ([responseJSONAsString rangeOfString:@"calendar#calendarList"].location != NSNotFound) {
        NSLog(@"*******************");
        NSError *error;
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseJSONAsData
                                                                          options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"Dictionary:%@",dictionary);
        array = [[NSMutableArray alloc]init];
        array = [dictionary valueForKey:@"items"];
        
        final = [[NSMutableArray alloc]init];
        for (NSMutableDictionary *dict in array) {
            NSLog(@"Calender:%@",dict);
            NSMutableDictionary *finalDict = [[NSMutableDictionary alloc]init];
            [finalDict setObject:[dict valueForKey:@"summary"] forKey:@"Name"];
            [finalDict setObject:[dict valueForKey:@"id"] forKey:@"id"];
            [final addObject:finalDict];
        }
        for (NSMutableDictionary *dicto in final) {

        }
        
    }else{
        NSError *error;
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseJSONAsData
                                                                          options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"RespOnse**:%@",dictionary);
    }
    [appointmentTableView reloadData];
}
-(void)authorizationWasSuccessful{
    [googleOAuth callAPI:@"https://www.googleapis.com/calendar/v3/users/me/calendarList"
           withHttpMethod:httpMethod_GET
       postParameterNames:nil postParameterValues:nil];
    
   // https://www.googleapis.com/calendar/v3/calendars/uvitft97ojh9302mqrg97ddkq4@group.calendar.google.com/events
}
- (IBAction)getEvents:(id)sender {
    [googleOAuth callAPI:@"https://www.googleapis.com/calendar/v3/calendars/uvitft97ojh9302mqrg97ddkq4@group.calendar.google.com/events"
          withHttpMethod:httpMethod_GET
      postParameterNames:nil postParameterValues:nil];
}

#pragma mart Tableview delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    eventsVC = [[KMEventsViewController alloc]init];
    NSDictionary *dict = [final objectAtIndex:indexPath.row];
    eventsVC.calenderId = [dict valueForKey:@"id"];
    [self.navigationController pushViewController:eventsVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell:%d",indexPath.row];
    UITableViewCell *cell = [appointmentTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
        UIImageView *accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
        [accessoryView setImage:[UIImage imageNamed:@"arrow_right.png"]];
        [cell setAccessoryView:accessoryView];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSLog(@"%@",array);
    NSDictionary *dic = [final objectAtIndex:indexPath.row];
   cell.textLabel.text = [dic valueForKey:@"Name"];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return [array count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;   {
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;{
    return @"Select Calendar:";
}
@end

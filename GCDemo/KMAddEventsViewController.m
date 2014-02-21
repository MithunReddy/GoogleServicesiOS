//
//  KMAddEventsViewController.m
//  GCDemo
//
//  Created by nunc03 on 2/20/14.
//  Copyright (c) 2014 Mithun Reddy. All rights reserved.
//

#import "KMAddEventsViewController.h"
#import "MBProgressHUD.h"
@interface KMAddEventsViewController ()
{
    UIActionSheet *sheet;
    NSMutableArray *final;
    BOOL CalendarPicker;
    NSDate *Sdate;
    NSDictionary *dictnry;
    MBProgressHUD *HUD;
}
@end

@implementation KMAddEventsViewController
@synthesize picker;
@synthesize dateText;
@synthesize titletext;
@synthesize calendarText;
@synthesize aouth;
@synthesize eventtxtPost;
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
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    final = [[NSMutableArray alloc]init];
    aouth = [[GoogleOAuth alloc]init];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];

    [aouth setGOAuthDelegate:self];
    [aouth authorizeUserWithClienID:CLIENT_ID
                    andClientSecret:CLIENT_SECRET
                      andParentView:self.view
                          andScopes:[NSArray arrayWithObjects:@"https://www.googleapis.com/auth/calendar", nil]
     ];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    // A single tap hides the slide menu
    [self.titletext resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showDatePicker:(id)sender {
    [self showPicker];
}

- (IBAction)ShowCalendarPicker:(id)sender {
    [self showCalenderPicker];
}
-(void)showPicker{
    CalendarPicker = NO;
    picker = [[UIDatePicker alloc]init];
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    mypickerToolbar.backgroundColor = [UIColor colorWithRed:13/255.0 green:33/255.0 blue:39/255.0 alpha:1.0];
    [mypickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *canclePicker = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(PickerCancleClicked)];
    [barItems addObject:canclePicker];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    [mypickerToolbar setItems:barItems animated:YES];
   sheet = [[UIActionSheet alloc] initWithTitle:nil
                                        delegate:self
                               cancelButtonTitle:@"Done"
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil];
    [sheet addSubview:picker];
    [sheet showInView:self.view.superview];
    [sheet addSubview:mypickerToolbar];
    [sheet showInView:self.view.superview];
    //picker.showsSelectionIndicator = YES;
    [sheet setBounds:CGRectMake(0, 0, 320, 320)];
}
-(void)pickerDoneClicked{
    if (CalendarPicker) {
        
    }else{
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateStyle = NSDateFormatterMediumStyle;
        dateText.text = [NSString stringWithFormat:@"%@",
                         [df stringFromDate:picker.date]];
        Sdate = [picker date];
        
    }

   [sheet dismissWithClickedButtonIndex:0 animated:YES];

}
-(void)PickerCancleClicked{
    [sheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)showCalenderPicker{
    CalendarPicker = YES;
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [pickerView  setShowsSelectionIndicator:YES];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    mypickerToolbar.backgroundColor = [UIColor colorWithRed:13/255.0 green:33/255.0 blue:39/255.0 alpha:1.0];
    [mypickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *canclePicker = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(PickerCancleClicked)];
    [barItems addObject:canclePicker];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    sheet = [[UIActionSheet alloc] initWithTitle:nil
                                        delegate:self
                               cancelButtonTitle:@"Done"
                          destructiveButtonTitle:nil
                               otherButtonTitles:nil];
    [sheet addSubview:pickerView];
    [sheet showInView:self.view.superview];
    [sheet addSubview:mypickerToolbar];
    [sheet showInView:self.view.superview];
    pickerView.showsSelectionIndicator = YES;
    [sheet setBounds:CGRectMake(0, 0, 320, 320)];
}
#pragma Mark Picker View Delegate Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return final.count;
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    NSDictionary *dic = [final objectAtIndex:row];
    return [dic valueForKey:@"Name"];
    
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    dictnry = [final objectAtIndex:row];
    calendarText.text = [dictnry valueForKey:@"Name"];
    NSLog(@"%@",[dictnry valueForKey:@"Name"]);
    
}
-(void)authorizationWasSuccessful{
    [aouth callAPI:@"https://www.googleapis.com/calendar/v3/users/me/calendarList"
          withHttpMethod:httpMethod_GET
      postParameterNames:nil postParameterValues:nil];
    
    // https://www.googleapis.com/calendar/v3/calendars/uvitft97ojh9302mqrg97ddkq4@group.calendar.google.com/events
}
-(void)responseFromServiceWasReceived:(NSString *)responseJSONAsString andResponseJSONAsData:(NSData *)responseJSONAsData;{
    
    if ([responseJSONAsString rangeOfString:@"calendar#calendarList"].location != NSNotFound) {
        NSLog(@"*******************");
        NSError *error;
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseJSONAsData
                                                                          options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"Dictionary:%@",dictionary);
      NSMutableArray  *array = [[NSMutableArray alloc]init];
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
        
    }else if ([responseJSONAsString rangeOfString:@"calendar#event"].location != NSNotFound){
        [HUD hide:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Event added sucessfully" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        titletext.text = nil;
        dateText.text =  nil;
        calendarText.text = nil;
        
    }else{
        NSError *error;
        NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseJSONAsData
                                                                          options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"RespOnse**:%@",dictionary);
    }
}
- (IBAction)addEvent:(id)sender {
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDAnimationFade;
    
    HUD.delegate = self;
    HUD.labelText = @"Adding..";
    
    // myProgressTask uses the HUD instance to update progress
    [HUD show:YES];

    NSString *apiURLString = [NSString stringWithFormat:@"https://www.googleapis.com/calendar/v3/calendars/%@/events/quickAdd",
                              [dictnry objectForKey:@"id"]];
    
    // Build the event text string, composed by the event description and the date (and time) that should happen.
    // Break the selected date into its components.
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit
                                                     fromDate:Sdate];
    eventtxtPost = [NSString stringWithFormat:@"%@ %d/%d/%d at %d.%d", titletext.text, [dateComponents month], [dateComponents day], [dateComponents year], [dateComponents hour], [dateComponents minute]];
    
    [aouth callAPI:apiURLString
           withHttpMethod:httpMethod_POST
       postParameterNames:[NSArray arrayWithObjects:@"calendarId", @"text", nil]
      postParameterValues:[NSArray arrayWithObjects:[dictnry objectForKey:@"id"], eventtxtPost, nil]];
    
}
@end

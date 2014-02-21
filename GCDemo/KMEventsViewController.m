//
//  KMEventsViewController.m
//  GCDemo
//
//  Created by nunc03 on 2/21/14.
//  Copyright (c) 2014 Mithun Reddy. All rights reserved.
//

#import "KMEventsViewController.h"
@interface KMEventsViewController (){
    NSMutableArray *array;
}
@end

@implementation KMEventsViewController
@synthesize aouth;
@synthesize calenderId;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    aouth = [[GoogleOAuth alloc]init];
    [aouth setGOAuthDelegate:self];
    [aouth authorizeUserWithClienID:CLIENT_ID
                          andClientSecret:CLIENT_SECRET
                            andParentView:self.view
                                andScopes:[NSArray arrayWithObjects:@"https://www.googleapis.com/auth/calendar", nil]
     ];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)authorizationWasSuccessful{
    [aouth callAPI:[NSString stringWithFormat:@"https://www.googleapis.com/calendar/v3/calendars/%@/events",calenderId] withHttpMethod:httpMethod_GET
postParameterNames:nil postParameterValues:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UILabel *lbl = [[UILabel alloc]init];
        lbl.frame = CGRectMake(250, 10, 65, 18);
        //lbl.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:lbl];
    }
    
    NSMutableDictionary *dict = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict valueForKey:@"Title"];
    cell.detailTextLabel.text = [dict valueForKey:@"loc"];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */
-(void)responseFromServiceWasReceived:(NSString *)responseJSONAsString andResponseJSONAsData:(NSData *)responseJSONAsData{
    NSError *error;
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseJSONAsData
                                                                      options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"*&&Dictionary$$:%@",dictionary);
    array = [[NSMutableArray alloc]init];
    if (dictionary != nil) {
        NSMutableArray *tempArray = [dictionary valueForKey:@"items"];
        for (NSMutableDictionary *dict in tempArray) {
            NSMutableDictionary *eventsDict = [[NSMutableDictionary alloc]init];
            [eventsDict setObject:[dict valueForKey:@"summary"] forKey:@"Title"];
            if ([dict valueForKey:@"location"] != nil) {
                [eventsDict setObject:[dict valueForKey:@"location"] forKey:@"loc"];
            }else{
                [eventsDict setObject:@"null" forKey:@"loc"];
            }

            [array addObject:eventsDict];
            
        }
        [self.tableView reloadData];
    }

}
-(void)errorInResponseWithBody:(NSString *)errorMessage;
{
    NSLog(@"%@",errorMessage);
}
@end

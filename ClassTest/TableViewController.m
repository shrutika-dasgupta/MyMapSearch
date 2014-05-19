//
//  TableViewController.m
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 3/28/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "TableViewController.h"
#import "COMSMapViewController.h"
#import "DetailsViewController.h"


@interface TableViewController ()
{
    int row;
    UIButton *addFavButton;
    
}

@end

@implementation TableViewController
@synthesize passedResults;
@synthesize myTable;
@synthesize tableArray;
@synthesize managedObjectContext;

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
    
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = appDelegate.managedObjectContext;

}


-(void)viewWillAppear:(BOOL) animated
{
    [super viewWillAppear: YES];
    
    
    self.passedResults = appDelegate.tableData;
    
    if([self.passedResults count] == 0)
    {
        //alert box is displayed when on results are found
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"TABLE RESULTS"
                              message: @"Table is empty!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
       
        self.tabBarController.selectedIndex= 0;
        
    }
    else
    {
        self.tableArray = self.passedResults;
        
    }
    
    
    [self.myTable reloadData];
    
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
    return [self.tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = [[self.tableArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Distance: %@ meters \n @: %@", [[self.tableArray objectAtIndex:indexPath.row] valueForKey:@"distance"],[[self.tableArray objectAtIndex:indexPath.row] valueForKey:@"vicinity"]];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.numberOfLines=2;
    
    addFavButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addFavButton.frame = CGRectMake(275.0f, 5.0f, 30.0f, 30.0f);
    
    [cell addSubview:addFavButton];
    [addFavButton addTarget:self
                        action:@selector(favButton:)
              forControlEvents:UIControlEventTouchUpInside];
    
    NSString *objid = [[NSString alloc] init];
    objid = [[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    NSManagedObjectContext *contextobj= self.managedObjectContext;
    
    NSFetchRequest *getData = [[NSFetchRequest alloc] initWithEntityName:@"MapDataModel"];
    getData.predicate = [NSPredicate predicateWithFormat:@"(objectid = %@)", objid];
    NSArray *array = [contextobj executeFetchRequest:getData error:nil];
   // NSLog(@"count--->%d",array.count);
    if(array.count ==0)
    {
        [addFavButton setBackgroundImage:[UIImage imageNamed:@"greyButton.png"] forState:UIControlStateNormal];
        [addFavButton setSelected:NO];
    }
    else
    {
        [addFavButton setBackgroundImage:[UIImage imageNamed:@"yellowButton.png"] forState:UIControlStateNormal];
        [addFavButton setSelected:YES];
    }
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    appDelegate.sharedDictionary = [self.tableArray objectAtIndex:indexPath.row];
  
    UIViewController *view1 = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    [self.navigationController pushViewController:view1 animated:YES];
 
}

- (IBAction)favButton:(id)sender
{
    //To get the position of the row selected.
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    row = indexPath.row;
    
    
    UIButton* button = (UIButton* )sender;
    if(button.selected)
    {
        NSError *error;
        //When the favorite button is selected and to Unselect the button
        [button setBackgroundImage:[UIImage imageNamed:@"greyButton.png"] forState:UIControlStateNormal];
        
       
        NSString *objid = [[NSString alloc] init];
        objid = [[self.tableArray objectAtIndex:indexPath.row] objectForKey:@"id"];
        
        NSManagedObjectContext *contextobj= self.managedObjectContext;
        NSFetchRequest *getData = [[NSFetchRequest alloc] initWithEntityName:@"MapDataModel"];
        getData.predicate = [NSPredicate predicateWithFormat:@"(objectid = %@)", objid];
        NSArray *array = [contextobj executeFetchRequest:getData error:&error];
        
        for (NSManagedObject *managedObject in array)
        {
            [contextobj deleteObject:managedObject];
        }
        
       //r [contextobj deleteObject:newEntry];
      
        if (![contextobj save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [button setSelected:NO];
       // [self.tableView reloadData];
        
    }
    else
    {
        //When the favorite button is not selected and to select teh favorite button
        [button setBackgroundImage:[UIImage imageNamed:@"yellowButton.png"] forState:UIControlStateNormal];
        [button setSelected:YES];
        
        
        NSDictionary *photoDict = [[[self.tableArray objectAtIndex:row] objectForKey:@"photos"] objectAtIndex:0];
        NSString *photoRef = [photoDict objectForKey:@"photo_reference"];
        
        //NSLog(@"photoRef: LEVIEWCONTROLLER::%@",photoRef);
        NSString *api_key =@"AIzaSyD7p3lc_bVBa8W9DYkC0fu5tyaQhAdmHYA";
        
        NSString *strURL=[[NSString alloc]init];
        
        if(photoRef == nil)
        {
            strURL =@"noImage";
        }
        else
        {
            strURL=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?photoreference=%@&key=%@&sensor=false&maxwidth=320", photoRef,api_key ];
        }
        
       // NSURL *url =[NSURL URLWithString:strURL];
        
        MapDataModel *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"MapDataModel" inManagedObjectContext:self.managedObjectContext];
        
        newEntry.name=[[self.tableArray objectAtIndex:row] objectForKey:@"name"];
        newEntry.icon=[[self.tableArray objectAtIndex:row] objectForKey:@"icon"];
        newEntry.address=[[self.tableArray objectAtIndex:row] objectForKey:@"vicinity"];
        newEntry.objectid = [[self.tableArray objectAtIndex:row] objectForKey:@"id"];
        newEntry.photoURL=strURL;
        newEntry.moreInfo=@"";
        newEntry.type=[[[self.tableArray objectAtIndex:row] objectForKey:@"types"] componentsJoinedByString:@","];
        
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
           // [self.view endEditing:YES];
        }
    }
    

  //  [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


@end

//
//  FavoriteController.m
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 3/31/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "FavoriteController.h"
#import "COMSAppDelegate.h"

@interface FavoriteController ()

@end

@implementation FavoriteController
{
    MapDataModel * record1;
}

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
  appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
   // self.fetchedFavArray = [appDelegate favouritesList];
    
     [self.tableView reloadData];
    
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)viewWillAppear:(BOOL)animated
{
   // [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MapDataModel"];
    self.fetchedFavArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
  
    [self.tableView reloadData];
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
    return [self.fetchedFavArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"favID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    record1 = [self.fetchedFavArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",record1.name];
    
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *recordPassed=[[NSMutableDictionary alloc] init];
    
    MapDataModel *record = [self.fetchedFavArray objectAtIndex:indexPath.row];
   // NSLog(@"%@",recordPassed);
    
    [recordPassed setObject:record.name forKey:@"name"];
    [recordPassed setObject:record.address forKey:@"address"];
    [recordPassed setObject:record.type forKey:@"type"];
    [recordPassed setObject:record.icon forKey:@"icon"];
    [recordPassed setObject:record.objectid forKey:@"objectid"];
    [recordPassed setObject:record.photoURL forKey:@"photoURL"];
 //   [recordPassed setObject:record.distance forKey:@"distance"];
    

    
    appDelegate.favDictionary=recordPassed;
    
  //  NSLog(@"record: %@",recordPassed);
    
    UIViewController *view1 = [self.storyboard instantiateViewControllerWithIdentifier:@"FavouriteDetailViewController"];
    [self.navigationController pushViewController:view1 animated:YES];
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.fetchedFavArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.fetchedFavArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (IBAction)DeleteAllDatabase:(id)sender
{
    NSError *error;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"MapDataModel"];
    NSArray *deleteAllArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for(NSManagedObject *obj in deleteAllArray)
    {
        [managedObjectContext deleteObject:obj];
    }
    [self.tableView reloadData];
}

@end

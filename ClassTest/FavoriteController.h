//
//  FavoriteController.h
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 3/31/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COMSAppDelegate.h"
#import "MapDataModel.h"
#import "FavouriteDetailViewController.h"



@interface FavoriteController : UITableViewController
{
    COMSAppDelegate *appDelegate;
}

@property (nonatomic,strong)NSMutableArray* fetchedFavArray;
@property (strong, nonatomic) IBOutlet UIButton *deleteAll;
@property (nonatomic,retain) IBOutlet UITableView *favTable;

@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (IBAction)DeleteAllDatabase:(id)sender;

@end

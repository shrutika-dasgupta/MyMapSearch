//
//  COMSAppDelegate.h
//  ClassTest
//
//  Created by Shrutika Dasgupta on 2/12/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapDataModel.h"

@interface COMSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableDictionary *sharedDictionary;
@property (nonatomic, strong) NSMutableDictionary *favDictionary;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

//
//  MapDataModel.h
//  MyMapSearch
//
//  Created by Shrutika Dasgupta on 3/31/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MapDataModel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * thumbnail;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * moreInfo;
@property (nonatomic, retain) NSString * objectid;

@end

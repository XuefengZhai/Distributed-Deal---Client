//
//  DS_DDBusiness.h
//  DS_DD1
//
//  Created by Armando Aguileta on 25/04/14.
//  Copyright (c) 2014 Armando Aguileta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>


@interface DS_DDBusiness : NSManagedObject <MKAnnotation>

@property (nonatomic, retain) NSNumber * b_id;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * ip;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * longtd;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *groups;
@end

@interface DS_DDBusiness (CoreDataGeneratedAccessors)

- (void)addGroupsObject:(NSManagedObject *)value;
- (void)removeGroupsObject:(NSManagedObject *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

@end

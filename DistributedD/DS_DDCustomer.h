//
//  DS_DDCustomer.h
//  DS_DD1
//
//  Created by Armando Aguileta on 25/04/14.
//  Copyright (c) 2014 Armando Aguileta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DS_DDCustomer : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * c_id;
@property (nonatomic, retain) NSNumber * custom_max;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sub_level;
@property (nonatomic, retain) NSSet *groups;
@end

@interface DS_DDCustomer (CoreDataGeneratedAccessors)

- (void)addGroupsObject:(NSManagedObject *)value;
- (void)removeGroupsObject:(NSManagedObject *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;

@end

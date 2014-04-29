//
//  DS_DDCustomerGroup.h
//  DS_DD1
//
//  Created by Armando Aguileta on 25/04/14.
//  Copyright (c) 2014 Armando Aguileta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DS_DDBusiness, DS_DDCustomer;

@interface DS_DDCustomerGroup : NSManagedObject

@property (nonatomic, retain) NSSet *customers;
@property (nonatomic, retain) DS_DDBusiness *business;
@end

@interface DS_DDCustomerGroup (CoreDataGeneratedAccessors)

- (void)addCustomersObject:(DS_DDCustomer *)value;
- (void)removeCustomersObject:(DS_DDCustomer *)value;
- (void)addCustomers:(NSSet *)values;
- (void)removeCustomers:(NSSet *)values;

@end

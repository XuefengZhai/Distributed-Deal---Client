//
//  DS_DDDeal.h
//  DS_DD1
//
//  Created by Armando Aguileta on 25/04/14.
//  Copyright (c) 2014 Armando Aguileta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DS_DDDeal : NSManagedObject

@property (nonatomic, retain) NSNumber * d_id;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * end_date;
@property (nonatomic, retain) NSString * max_cust;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * start_date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;

@end

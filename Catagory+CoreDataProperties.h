//
//  Catagory+CoreDataProperties.h
//  Core data from contact
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 Pentac Solution. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Catagory.h"

NS_ASSUME_NONNULL_BEGIN

@interface Catagory (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *friend;
@property (nullable, nonatomic, retain) NSString *other;
@property (nullable, nonatomic, retain) NSString *business;
@property (nullable, nonatomic, retain) NSString *relatives;
@property (nullable, nonatomic, retain) NSString *commercial;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END

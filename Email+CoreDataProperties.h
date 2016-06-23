//
//  Email+CoreDataProperties.h
//  Core data from contact
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 Pentac Solution. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Email.h"

NS_ASSUME_NONNULL_BEGIN

@interface Email (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *subid;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END

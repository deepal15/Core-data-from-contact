//
//  User+CoreDataProperties.h
//  Core data from contact
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 Pentac Solution. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstname;
@property (nullable, nonatomic, retain) id image;
@property (nullable, nonatomic, retain) NSString *lastname;
@property (nullable, nonatomic, retain) NSSet<Address *> *addresses;
@property (nullable, nonatomic, retain) NSSet<Email *> *emails;
@property (nullable, nonatomic, retain) NSSet<Mobile *> *numbers;
@property (nullable, nonatomic, retain) NSManagedObject *catagories;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAddressesObject:(Address *)value;
- (void)removeAddressesObject:(Address *)value;
- (void)addAddresses:(NSSet<Address *> *)values;
- (void)removeAddresses:(NSSet<Address *> *)values;

- (void)addEmailsObject:(Email *)value;
- (void)removeEmailsObject:(Email *)value;
- (void)addEmails:(NSSet<Email *> *)values;
- (void)removeEmails:(NSSet<Email *> *)values;

- (void)addNumbersObject:(Mobile *)value;
- (void)removeNumbersObject:(Mobile *)value;
- (void)addNumbers:(NSSet<Mobile *> *)values;
- (void)removeNumbers:(NSSet<Mobile *> *)values;

@end

NS_ASSUME_NONNULL_END

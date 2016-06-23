//
//  ViewController.m
//  Core data from contact
//
//  Created by Apple on 26/05/16.
//  Copyright © 2016 Pentac Solution. All rights reserved.
//

#import "ViewController.h"
#import <Contacts/Contacts.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "User.h"
#import "Mobile.h"
#import "Email.h"
#import "Address.h"


@interface ViewController ()


@property (strong, nonatomic) NSMutableArray *arrayContacts;

@end

@implementation ViewController



-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.arrayContacts = [[NSMutableArray alloc]init];
  
    [self contactScan];
    
    
   // perfectly working for core data
        
//        NSDictionary *dictionary = [[NSDictionary alloc]init];
//    for (int i = 0; i < [self.arrayContacts count]; i++) {
//        
//        dictionary = [self.arrayContacts objectAtIndex:i];
//        
//        
//        NSLog(@"%@",[dictionary valueForKey:@"firstName"]);
//        NSLog(@"%@",[dictionary valueForKey:@"lastName"]);
//        
//        
//        for (int i1 = 0; i1 < [[dictionary valueForKey:@"mobile"] count]; i1++) {
//            NSLog(@"%@",[[dictionary valueForKey:@"mobile"]objectAtIndex:i1]);
//        }
//        
//        for (int i1 = 0; i1 < [[dictionary valueForKey:@"email"] count]; i1++) {
//            NSLog(@"%@",[[dictionary valueForKey:@"email"]objectAtIndex:i1]);
//        }
//        
//        for (int i1 = 0; i1 < [[dictionary valueForKey:@"address"] count]; i1++) {
//            NSLog(@"%@",[[dictionary valueForKey:@"address"]objectAtIndex:i1]);
//        }
//        NSLog(@"%@",[dictionary valueForKey:@"image"]);
//        
//        NSLog(@"______________________________________________________________________");
//    }

}




- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - contact access




- (void) contactScan
{
    if ([CNContactStore class]) {
        //ios9 or later
        CNEntityType entityType = CNEntityTypeContacts;
        if( [CNContactStore authorizationStatusForEntityType:entityType] == CNAuthorizationStatusNotDetermined)
        {
            CNContactStore * contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:entityType completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if(granted){
                    [self getAllContact];
                }
            }];
        }
        else if( [CNContactStore authorizationStatusForEntityType:entityType]== CNAuthorizationStatusAuthorized)
        {
            [self getAllContact];
        }
        //else{ [self alert]; }
    }
    
}

-(void)getAllContact
{
    if([CNContactStore class])
    {
        //iOS 9 or later
        NSError* contactError;
        CNContactStore* addressBook = [[CNContactStore alloc]init];
        [addressBook containersMatchingPredicate:[CNContainer predicateForContainersWithIdentifiers: @[addressBook.defaultContainerIdentifier]] error:&contactError];
        NSArray * keysToFetch =@[CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPostalAddressesKey, CNContactImageDataKey];
        CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keysToFetch];
        BOOL success = [addressBook enumerateContactsWithFetchRequest:request error:&contactError usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
            [self parseContactWithContact:contact];
        }];
    }
}

- (void)parseContactWithContact :(CNContact* )contact
{
    
    NSString * firstName =  contact.givenName;
    NSString * lastName =  contact.familyName;
    NSString * phone = [[contact.phoneNumbers valueForKey:@"value"] valueForKey:@"digits"];
    NSString * email = [contact.emailAddresses valueForKey:@"value"];
    UIImage *imag = [UIImage imageWithData:contact.imageData];
//    [self.arrayFirstName addObject:firstName];
//    [self.arrayLastName addObject:lastName];
    if (imag == nil) {
       
        imag = [UIImage imageNamed:@"fb.png"];
        
    }
    else{
      
    }
    NSArray * addrArr = [self parseAddressWithContac:contact];
    
    
    
    [self.arrayContacts addObject:@{@"firstName":firstName,
                                         @"lastName":lastName,
                                         @"mobile":phone,
                                         @"email":email,
                                         @"image":imag,
                                         @"address":addrArr}];
    
  //  NSLog(@"\nNew :%@\n%@\n%@\n%@\n%@\n%@",firstName,lastName,phone,email,addrArr,imag);
   // [self.tableView1 reloadData];
    
}

- (NSMutableArray *)parseAddressWithContac: (CNContact *)contact
{
    NSMutableArray * addrArr = [[NSMutableArray alloc]init];
    CNPostalAddressFormatter * formatter = [[CNPostalAddressFormatter alloc]init];
    NSArray * addresses = (NSArray*)[contact.postalAddresses valueForKey:@"value"];
    if (addresses.count > 0) {
        for (CNPostalAddress* address in addresses) {
            [addrArr addObject:[formatter stringFromPostalAddress:address]];
        }
    }
    return addrArr;
}

// saving to the data base working
- (IBAction)save:(id)sender
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    for (NSDictionary *dic in self.arrayContacts)
    {
        User *objUser;
        Mobile *objMobile;
        Email *objEmail;
        Address *objAddress;
        NSMutableArray *arrayTempPhone;
        NSMutableArray *arrayTempAddress;
        NSMutableArray *arrayTempEmail;
        
        objUser = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([User class]) inManagedObjectContext:context];
        
      //  objMobile = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Mobile class]) inManagedObjectContext:context];
        
//        objEmail = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Email class]) inManagedObjectContext:context];
        
//        objAddress = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Address class]) inManagedObjectContext:context];
        
        

        
        arrayTempPhone = [[NSMutableArray alloc]init];
        for (int i = 0; i < [[dic valueForKey:@"mobile"] count] ; i++)
        {
            objMobile = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Mobile class]) inManagedObjectContext:context];
            
            
            objMobile.number = [[dic valueForKey:@"mobile"]objectAtIndex:i];
            objMobile.subid = [NSString stringWithFormat:@"%@",[objUser objectID]];
            [objUser addNumbersObject:objMobile];
         //   NSLog(@"%@",objMobile.number);
            
            
        }
        
        //working demo
//        NSLog(@"%@",objMobile);
//        NSLog(@"%@",[objUser.numbers valueForKey:@"number"]);
//        NSLog(@"%@",[objUser.numbers valueForKey:@"subid"]);
      
        
        
        arrayTempEmail = [[NSMutableArray alloc]init];
        for (int i = 0; i < [[dic valueForKey:@"email"] count] ; i++)
        {
            objEmail = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Email class]) inManagedObjectContext:context];

            
            
            objEmail.email = [[dic valueForKey:@"email"]objectAtIndex:i];
            objEmail.subid = [NSString stringWithFormat:@"%@",[objUser objectID]];
            [objUser addEmailsObject:objEmail];
         //    NSLog(@"%@",objEmail.email);
        }

        
        arrayTempAddress = [[NSMutableArray alloc]init];
        for (int i = 0; i < [[dic valueForKey:@"address"] count] ; i++)
        {
             objAddress = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Address class]) inManagedObjectContext:context];
            
            
            objAddress.address = [[dic valueForKey:@"address"]objectAtIndex:i];
            objAddress.subid = [NSString stringWithFormat:@"%@",[objUser objectID]];
            
            [objUser addAddressesObject:objAddress];
       //     NSLog(@"%@",objAddress.address);
            
        }
//
//       
//        
//        //[objUser addNumbersObject:objMobile];
//      
//        
//        
//        
        objUser.firstname = [dic valueForKey:@"firstName"];
        objUser.lastname = [dic valueForKey:@"lastName"];
        objUser.image = [dic valueForKey:@"image"];
       objMobile.user = objUser;
//        objAddress.users = objUser;
//        objEmail.user = objUser;
//     //   wokring
//        NSSet *set1 = [NSSet setWithArray:arrayTempPhone];
//        NSSet *set2 = [NSSet setWithArray:arrayTempEmail];
//        NSSet *set3 = [NSSet setWithArray:arrayTempAddress];
//        [objUser addNumbers:set1];
//        [objUser addEmails:set2];
//        [objUser addAddresses:set3];
//     NSLog(@"%@",objUser);
    }
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}
// retrive from data base working
- (IBAction)retrive:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([User class])];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    User *user;
    
    for (int i = 0; i < array.count; i++) {
        user = (User *)[array objectAtIndex:i];
      
        NSLog(@"%@",user.firstname);
        NSLog(@"%@",user.lastname);
        NSLog(@"%@",user.image);
        

        NSArray *arrayNumber = [(NSSet *)[user.numbers valueForKey:@"number"]allObjects];
        for (int i = 0 ; i < [arrayNumber count]; i++) {
            NSLog(@"%@",[arrayNumber objectAtIndex:i]);
        }
        
        
        
        NSArray *arrayAddress = [(NSSet *)[user.addresses valueForKey:@"address"]allObjects];
        NSString *strAddress;
        for (int i = 0; i < [arrayAddress count]; i++) {
            strAddress = [arrayAddress  objectAtIndex:i];
            strAddress = [strAddress stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSLog(@"%@",strAddress);
        }
        
        NSArray *arrayEmail = [(NSSet *)[user.emails valueForKey:@"email"]allObjects];
        for (int i = 0; i < [arrayEmail count]; i++) {
            NSLog(@"%@",[arrayEmail objectAtIndex:i]);
        }
        
     
    }
    
}





// search particular user by name working
- (IBAction)btn:(id)sender {
    
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([User class])];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@",self.textField.text];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    User *user;
    
    
    
    for (int i = 0; i < array.count; i++) {
        user = (User *)[array objectAtIndex:i];
        NSLog(@"%@",user.firstname);
        NSLog(@"%@",user.lastname);
        NSLog(@"%@",user.image);
        
        NSArray *arrayNumber = [(NSSet *)[user.numbers valueForKey:@"number"]allObjects];
        for (int i = 0 ; i < [arrayNumber count]; i++) {
            NSLog(@"%@",[arrayNumber objectAtIndex:i]);
        }
       
        
        
        NSArray *arrayAddress = [(NSSet *)[user.addresses valueForKey:@"address"]allObjects];
        NSString *strAddress;
        for (int i = 0; i < [arrayAddress count]; i++) {
            strAddress = [arrayAddress  objectAtIndex:i];
            strAddress = [strAddress stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSLog(@"%@",strAddress);
        }
    
        NSArray *arrayEmail = [(NSSet *)[user.emails valueForKey:@"email"]allObjects];
        for (int i = 0; i < [arrayEmail count]; i++) {
            NSLog(@"%@",[arrayEmail objectAtIndex:i]);
        }
        

    }

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


// delete particular user working
- (IBAction)delete:(id)sender {
    

    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([User class])];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@",self.textDelete.text];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    User *user;
    
    for (int i = 0; i < array.count; i++) {
        user = (User *)[array objectAtIndex:i];
        [context deleteObject:user];
    }
    
    
    
   

}

// update particular detail
- (IBAction)update:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([Mobile class])];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"number ==  %@",self.textUpdate.text];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    Mobile *objMobile = (Mobile *)[array objectAtIndex:0];
    objMobile.number = self.textReplacingNo.text;
    NSError *deleteError = nil;
    if (![objMobile.managedObjectContext save:&deleteError]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
    }

}


//add detail into existing once working
- (IBAction)addParticularDetail:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([User class])];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@",self.textField.text];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    Mobile *objMobile;
    User *objUser;
    
    objUser = [array objectAtIndex:0];
    
    for (int i = 0; i < array.count; i++)
    {
        objMobile = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Mobile class]) inManagedObjectContext:context];
        objMobile.number = [NSString stringWithFormat:@"%@",self.textAddUserDetail.text];
        objMobile.subid = [NSString stringWithFormat:@"%@",[objUser objectID]];
        [objUser addNumbersObject:objMobile];
        NSLog(@"%@",[objUser.numbers valueForKey:@"number"]);
        self.textAddUserDetail.text = @"";
    }
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}

//delete detail from existing once.
- (IBAction)deleteMobileDetail:(id)sender {
    
    
    //deleting
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([Mobile class])];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"number ==  %@",self.textDeleteMobileDetail.text];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];

    Mobile *person = (Mobile *)[array objectAtIndex:0];
    [self.managedObjectContext deleteObject:person];
    
    NSError *deleteError = nil;
    
    if (![person.managedObjectContext save:&deleteError]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", deleteError, deleteError.localizedDescription);
    }
    
  
    
   
    
}
@end

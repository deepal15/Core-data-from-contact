//
//  NextViewController.m
//  Core data from contact
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 Pentac Solution. All rights reserved.
//

#import "NextViewController.h"
#import <CoreData/CoreData.h>
#import "User.h"
#import "Mobile.h"
#import "Email.h"
#import "Address.h"
#import "Catagory.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)btn:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([User class])];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@",self.textName.text];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    User *objUser;
    Catagory *objCatagory;
    
    //objUser = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([User class]) inManagedObjectContext:context];
    
    
    objCatagory = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Catagory class]) inManagedObjectContext:context];
        
    
    
    objCatagory.friend = self.textName.text;
    
    NSError *error1 = nil;
    if (![context save:&error1])
    {
        NSLog(@"Can't Save! %@ %@", error1, [error1 localizedDescription]);
    }


    
}

- (IBAction)retrive:(id)sender {
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([Catagory class])];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@",self.textName.text];
    //[request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    Catagory *user;
    
    
    for (int i = 0; i < array.count; i++)
    {
        user = (Catagory *)[array objectAtIndex:i];
        
        NSLog(@"%@",user.friend);

        
        
        
    }
   
}





@end

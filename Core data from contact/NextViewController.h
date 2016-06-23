//
//  NextViewController.h
//  Core data from contact
//
//  Created by Apple on 16/06/16.
//  Copyright © 2016 Pentac Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textName;
- (IBAction)btn:(id)sender;
- (IBAction)retrive:(id)sender;

@end

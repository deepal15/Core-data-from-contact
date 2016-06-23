//
//  ViewController.h
//  Core data from contact
//
//  Created by Apple on 26/05/16.
//  Copyright © 2016 Pentac Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)btn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textDelete;
- (IBAction)delete:(id)sender;
- (IBAction)update:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textAddUserDetail;
@property (weak, nonatomic) IBOutlet UITextField *textReplacingNo;

- (IBAction)addParticularDetail:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textDeleteMobileDetail;

- (IBAction)deleteMobileDetail:(id)sender;







//update
@property (weak, nonatomic) IBOutlet UITextField *textUpdate;

@end


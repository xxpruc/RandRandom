//
//  AdderTableViewController.m
//  RandomPicker
//
//  Created by Xiaopeng Xu on 9/19/13.
//  Copyright (c) 2013 Xiaopeng Xu. All rights reserved.
//

#import "AdderTableViewController.h"

@interface AdderTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addTextField;

@end

@implementation AdderTableViewController


- (UITextField*) addTextField{
    return _addTextField;
}

- (NSString*) newItem{
    return self.addTextField.text;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.addTextField.keyboardType = UIKeyboardTypeDefault;
    self.addTextField.returnKeyType = UIReturnKeyDone;
    [self.addTextField becomeFirstResponder];
}




@end

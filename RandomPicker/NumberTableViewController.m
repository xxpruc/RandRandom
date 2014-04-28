//
//  NumberTableViewController.m
//  RandomPicker
//
//  Created by Xiaopeng Xu on 9/18/13.
//  Copyright (c) 2013 Xiaopeng Xu. All rights reserved.
//

#import "NumberTableViewController.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface NumberTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *minTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (readwrite, nonatomic) int min;
@property (readwrite, nonatomic) int max;

@end

@implementation NumberTableViewController




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.minTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.maxTextField.keyboardType = UIKeyboardTypeNumberPad;
    //tapGesture is used to capture any tap
    //whenever there's a tap, then go to -(void)hideKeyBoard
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];


}
/* Whenever there's a tap, jump to here */
-(void)hideKeyBoard {
    [self.minTextField resignFirstResponder];
    [self.maxTextField resignFirstResponder];
}


- (IBAction)didGenerate:(UIButton *)sender {
    [self hideKeyBoard];
    self.resultLabel.text = nil;
    int min = [self.minTextField.text intValue];
    int max = [self.maxTextField.text intValue];
    if (min && max && max > min){
        int result = arc4random() % (max - min + 1) + min;
        self.resultLabel.text = [NSString stringWithFormat:@"%d", result];
        NSString *history = self.historyLabel.text;
        self.historyLabel.text = [self updateHistoryString:history withResult:result];
        
    }else{
        self.resultLabel.text = @"Please validate your input!";
        self.resultLabel.textColor = [UIColor redColor];
    }
}
- (IBAction)didClear:(UIButton *)sender {
    [self hideKeyBoard];
    self.minTextField.text = nil;
    self.maxTextField.text = nil;
    self.historyLabel.text = nil;
    self.resultLabel.text = nil;
}

- (NSString*) updateHistoryString: (NSString*) string withResult: (int) result
{
    if ([string isEqualToString:@""]){
        string = [NSString stringWithFormat:@"%d", result];
    }else{
        string = [string stringByAppendingString:[NSString stringWithFormat:@",%d", result]];
    }
    return string;
}


@end

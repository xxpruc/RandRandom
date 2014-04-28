//
//  RandomPickerViewController.m
//  RandomPicker
//
//  Created by Xiaopeng Xu on 9/19/13.
//  Copyright (c) 2013 Xiaopeng Xu. All rights reserved.
//

#import "RandomPickerViewController.h"
#import "AdderTableViewController.h"

@interface RandomPickerViewController ()
@property (weak, nonatomic) IBOutlet UIView *randomPicker;
@property (strong, nonatomic) IBOutlet UITabBarItem *tabBar;
@end



@implementation RandomPickerViewController



- (void)addItem:(NSString*)item
{
    UILabel *itemLabel = [[UILabel alloc]init];
    
    static NSDictionary *colors = nil;
    if (!colors) colors =  @{ @"blue" : [UIColor blueColor],
                            @"green" : [UIColor greenColor],
                            @"orange" : [UIColor orangeColor],
                            @"red" : [UIColor redColor],
                            @"purple" : [UIColor purpleColor],
                            @"brown" : [UIColor brownColor] };
    
    NSArray *keyNames = [colors allKeys];
    int randomNames = arc4random()%[keyNames count];
    NSString *key = [keyNames objectAtIndex:randomNames];
    itemLabel.textColor = [colors objectForKey:key];
    itemLabel.text = item;
    itemLabel.font = [UIFont systemFontOfSize:arc4random()%10+20];
    itemLabel.backgroundColor = [UIColor clearColor];
    [self setRandomLocationForView:itemLabel];
    [self.randomPicker addSubview:itemLabel];

}

- (void)setRandomLocationForView:(UIView *)view
{
    [view sizeToFit];
    CGRect sinkBounds = CGRectInset(self.randomPicker.bounds, view.frame.size.width/2, view.frame.size.height/2);
    CGFloat x = arc4random() % (int)sinkBounds.size.width + view.frame.size.width/2;
    CGFloat y = arc4random() % (int)sinkBounds.size.height + view.frame.size.height/2;
    view.center = CGPointMake(x, y);
}

- (NSString*) getRandomResult
{
    NSString *selectedItem = nil;
    for (UIView *subView in self.randomPicker.subviews){
        UILabel *label = [[UILabel alloc]init];
//        NSLog(@"Subviews:%@", self.randomPicker.subviews);
        if ([subView isKindOfClass:[UILabel class]]){
            
            label = (UILabel*)subView;
            selectedItem = label.text;
        }
    }
    return selectedItem;
}



- (IBAction)random:(UIBarButtonItem *)sender {
    NSString *result = [self getRandomResult];
//    NSLog (@"The result is:%@", result);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Your Choice:" message:result delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"Reset", nil];

    //[[UIAlertView alloc]initWithTitle:@"Your Choice" message:result delegate:nil cancelButtonTitle:@"" otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        //cancel clicked ...do nothing and return
    }else{
        //reset clicked
        [[self.randomPicker subviews]
         makeObjectsPerformSelector:@selector(removeFromSuperview)];    }
}


- (IBAction)cancelAdding:(UIStoryboardSegue*)segue
{
}

- (IBAction)doneAdding:(UIStoryboardSegue*) segue
{
    AdderTableViewController *adder = segue.sourceViewController;
    [self addItem:adder.newItem];
}

@end

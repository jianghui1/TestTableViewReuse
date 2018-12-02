//
//  ViewController.m
//  TestTableViewReuse
//
//  Created by ys on 2018/12/1.
//  Copyright © 2018 mg. All rights reserved.
//

#import "ViewController.h"

#import "CodeTableViewController.h"
#import "XibViewController.h"
#import "StoryBoardDynamicTableViewController.h"
#import "StoryBoardStaticTableViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL isReuse;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)codeReuseAction:(id)sender {
    CodeTableViewController *vc = [CodeTableViewController new];
    vc.isReuse = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)codeNoReuseAction:(id)sender {
    CodeTableViewController *vc = [CodeTableViewController new];
    vc.isReuse = NO;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)xibReuseAction:(id)sender {
    XibViewController *vc = [XibViewController new];
    vc.isReuse = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)xibNoReuseAction:(id)sender {
    XibViewController *vc = [XibViewController new];
    vc.isReuse = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)storyboardDynamicReuseAction:(id)sender {
    self.isReuse = YES;
    [self performSegueWithIdentifier:@"dynamic" sender:sender];
}

- (IBAction)storyboardDynamicReuse1Action:(id)sender {
    [self performSegueWithIdentifier:@"dynamic1" sender:sender];
}

- (IBAction)storyboardDynamicNoReuseAction:(id)sender {
    self.isReuse = NO;
    [self performSegueWithIdentifier:@"dynamic" sender:sender];
}


- (IBAction)storyboardStaticReuseAction:(id)sender {
    self.isReuse = YES;
    [self performSegueWithIdentifier:@"static" sender:sender];
}

- (IBAction)storyboardStaticNoReuseAction:(id)sender {
    self.isReuse = NO;
    [self performSegueWithIdentifier:@"static" sender:sender];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"dynamic"]) {
        StoryBoardDynamicTableViewController *vc = segue.destinationViewController;
        vc.isReuse = _isReuse;
    }
    else if ([segue.identifier isEqualToString:@"static"]) {
        StoryBoardStaticTableViewController *vc = segue.destinationViewController;
        vc.isReuse = _isReuse;
    }
}

@end

//
//  PhoneInfoViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/21/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "PhoneInfoViewController.h"

@interface PhoneInfoViewController ()

@end

@implementation PhoneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RSSchool Task 6";
}

- (IBAction)tempAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

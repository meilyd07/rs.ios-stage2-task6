//
//  FileInfoViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/20/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "FileInfoViewController.h"

@interface FileInfoViewController ()

@end

@implementation FileInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end

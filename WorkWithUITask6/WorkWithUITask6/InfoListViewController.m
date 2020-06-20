//
//  InfoListViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/20/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "InfoListViewController.h"
#import "FileInfoViewController.h"

@interface InfoListViewController ()

@end

@implementation InfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Info";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)tempAction:(id)sender {
    FileInfoViewController *fileInfoVC = [FileInfoViewController new];
    [self.navigationController pushViewController:fileInfoVC animated:YES];
}

@end

//
//  InfoListViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/20/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "InfoListViewController.h"
#import "FileInfoViewController.h"
#import "UIColor+HexColors.h"
#import "InfoCell.h"
#import <Photos/Photos.h>

@interface InfoListViewController () <UITableViewDelegate, UITableViewDataSource, PHPhotoLibraryChangeObserver>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *assets;
@end

@implementation InfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assets = [NSMutableArray<PHAsset *> new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fillInitialDataSource];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.title = @"";
}

-(void)setupNavigationBar {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (@available(iOS 13, *)) {
        self.navigationController.navigationBar.standardAppearance = [[UINavigationBarAppearance alloc] init];
        [self.navigationController.navigationBar.standardAppearance configureWithDefaultBackground];
        self.navigationController.navigationBar.standardAppearance.backgroundColor = [UIColor customYellow];
       self.navigationController.navigationBar.standardAppearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor customBlack], NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]};
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor customYellow];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor customBlack], NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]};
    }
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"Info";
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"InfoCell"
                                                      owner:self options:nil];
        cell = (InfoCell *)[nibs objectAtIndex:0];
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor customYellowHighlighted];
    [cell setSelectedBackgroundView:bgColorView];
    [cell configureWithItem:self.assets[indexPath.row]];
    return cell;

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 116.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FileInfoViewController *fileInfoVC = [FileInfoViewController new];
    fileInfoVC.assetItem = self.assets[indexPath.row];
    [self.navigationController pushViewController:fileInfoVC animated:YES];
}

#pragma mark - Data source init

- (void)fillInitialDataSource {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
            [self getAssets];
        }
    }];
}

-(void)getAssets{
    self.assets = [NSMutableArray new];

    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[
        [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES],
    ];

    
    PHFetchResult *allAssetsResults  = [PHAsset fetchAssetsWithOptions:fetchOptions];
    [allAssetsResults enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([object isKindOfClass:[PHAsset class]]) {
            [self.assets addObject:object];
        }
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
    [self getAssets];
}
@end

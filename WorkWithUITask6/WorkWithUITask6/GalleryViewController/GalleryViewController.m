//
//  GalleryViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/21/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "GalleryViewController.h"
#import <Photos/Photos.h>
#import "AssetCollectionCell.h"
#import "UIColor+HexColors.h"
#import "ImagePreviewViewController.h"
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import "PHAsset+URL.h"

@interface GalleryViewController () <UICollectionViewDataSource, UICollectionViewDelegate, PHPhotoLibraryChangeObserver, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *assets;
@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Gallery";
    self.assets = [NSMutableArray<PHAsset *> new];
    [self createCollectionView];
    [self fillInitialDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationBar];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        return CGSizeMake(self.collectionView.bounds.size.width / 3 - 4, self.collectionView.bounds.size.width / 3 - 4);
    } else {
        return CGSizeMake(self.collectionView.bounds.size.width / 4 - 4, self.collectionView.bounds.size.width / 4 - 4);
    }
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
    self.navigationItem.title = @"Gallery";
}


- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layout setSectionInset:UIEdgeInsetsMake(4, 4, 4, 4)];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    self.collectionView.backgroundColor = [UIColor customWhite];
    UINib *nib = [UINib nibWithNibName:@"AssetCollectionCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"AssetCollectionCell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AssetCollectionCell *cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AssetCollectionCell" forIndexPath:indexPath];
    [cell configureWithItem:self.assets[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PHAsset *asset = self.assets[indexPath.row];
    if (asset.mediaType == PHAssetMediaTypeImage) {
        
        ImagePreviewViewController *fileInfoVC = [ImagePreviewViewController new];
        fileInfoVC.assetItem = asset;
        fileInfoVC.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:fileInfoVC animated:YES completion:nil];
    } else if (asset.mediaType == PHAssetMediaTypeVideo) {
        
        NSURL *videoURL = [asset getFileURLFromPHAssetResourceDescription];
        AVPlayerItem* playerItem = [AVPlayerItem playerItemWithURL:videoURL];
        AVPlayer* playVideo = [[AVPlayer alloc] initWithPlayerItem:playerItem];
        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        playerViewController.player = playVideo;
        playerViewController.view.frame = self.view.bounds;
        [self presentViewController:playerViewController animated:YES completion:nil];
    }
    
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
        [self.collectionView reloadData];
    });
}

- (void)photoLibraryDidChange:(nonnull PHChange *)changeInstance {
    [self getAssets];
}

@end

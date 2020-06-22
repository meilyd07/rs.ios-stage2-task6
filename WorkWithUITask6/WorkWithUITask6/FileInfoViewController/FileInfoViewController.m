//
//  FileInfoViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/20/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "FileInfoViewController.h"
#import "UIColor+HexColors.h"
#import "PHAsset+URL.h"

int const SHARE_BOTTON_HEIGHT = 55;

@interface FileInfoViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *modifIсationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property(nonatomic, strong) UIButton *shareButton;

@end

@implementation FileInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor customWhite];
    [self loadData];
    [self setupButton];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)loadData {
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

    requestOptions.synchronous = YES;
    PHImageManager *manager = [PHImageManager defaultManager];
    
    [manager requestImageForAsset:self.assetItem
       targetSize:CGSizeMake(self.view.frame.size.width - 40, self.view.frame.size.height)
      contentMode:PHImageContentModeAspectFit
          options:requestOptions
    resultHandler:^void(UIImage *image, NSDictionary *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image];
        });
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss dd.MM.yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:self.assetItem.creationDate];
    self.createDateLabel.text = dateString;
    NSString *modificationDateString = [dateFormatter stringFromDate:self.assetItem.modificationDate];
    self.modifIсationDateLabel.text = modificationDateString;
    
    switch (self.assetItem.mediaType) {
        case PHAssetMediaTypeImage:
            self.typeLabel.text = @"Image";
            break;
        case PHAssetMediaTypeAudio:
            self.typeLabel.text = @"Audio";
            break;
        case PHAssetMediaTypeVideo:
            self.typeLabel.text = @"Video";
            break;
        default:
            self.typeLabel.text = @"Other";
            break;
    }
}

- (void)setupButton {
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.shareButton.frame = CGRectMake(55, 250, 100.0, 55.0);
    [self.shareButton setTitle:@"Share" forState:UIControlStateNormal];
    self.shareButton.backgroundColor = [UIColor customYellow];
    [self.shareButton setTitleColor:[UIColor customBlack] forState:UIControlStateNormal];
    [self.shareButton.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    
    [self.shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton.layer.cornerRadius = SHARE_BOTTON_HEIGHT / 2;
    self.shareButton.clipsToBounds = YES;
    [self.contentView addSubview:self.shareButton];

}

-(void)shareAction:(UIButton *)button {
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[[self.assetItem getFileURLFromPHAssetResourceDescription]] applicationActivities:nil];
    
    activityVC.excludedActivityTypes = @[UIActivityTypeSaveToCameraRoll];
    activityVC.modalPresentationStyle = UIModalPresentationPopover;
    activityVC.popoverPresentationController.sourceView = button;
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)setupConstraints {
    [self addScrollConstraints];
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20].active = YES;
    [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20].active = YES;
    
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.stackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:20].active = YES;
    [self.stackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.stackView.topAnchor constant:-30].active = YES;

    self.shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.shareButton.heightAnchor constraintEqualToConstant:SHARE_BOTTON_HEIGHT].active = YES;

    [self.shareButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:55].active = YES;
    [self.shareButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-55].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:self.shareButton.topAnchor constant:-30].active = YES;
    
    [self.contentView.bottomAnchor constraintEqualToAnchor:self.shareButton.bottomAnchor constant:30].active = YES;
}

- (void)addScrollConstraints {
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *equalWidth = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1.0f
                                                                   constant:0];
    [self.view addConstraint:equalWidth];
    
    NSLayoutConstraint *pinScrollLeading = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0];
    NSLayoutConstraint *pinScrollTrailing = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0];
    NSLayoutConstraint *pinScrollTop = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0];
    NSLayoutConstraint *pinScrollBottom = [NSLayoutConstraint constraintWithItem:self.scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0];
    [self.view addConstraint:pinScrollLeading];
    [self.view addConstraint:pinScrollTrailing];
    [self.view addConstraint:pinScrollTop];
    [self.view addConstraint:pinScrollBottom];
    
    NSLayoutConstraint *pinContentLeading = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0];
    NSLayoutConstraint *pinContentTrailing = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0];
    NSLayoutConstraint *pinContentTop = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0];
    NSLayoutConstraint *pinContentBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0];
    [self.scrollView addConstraint:pinContentLeading];
    [self.scrollView addConstraint:pinContentTrailing];
    [self.scrollView addConstraint:pinContentTop];
    [self.scrollView addConstraint:pinContentBottom];
}

@end

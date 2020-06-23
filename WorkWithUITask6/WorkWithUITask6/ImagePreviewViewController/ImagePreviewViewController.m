//
//  ImagePreviewViewController.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/23/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "ImagePreviewViewController.h"
#import "UIColor+HexColors.h"

@interface ImagePreviewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImagePreviewViewController

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadData {
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

    requestOptions.synchronous = YES;
    PHImageManager *manager = [PHImageManager defaultManager];
    
    [manager requestImageForAsset:self.assetItem
       targetSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)
      contentMode:PHImageContentModeAspectFit
          options:requestOptions
    resultHandler:^void(UIImage *image, NSDictionary *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image];
        });
    }];
}


@end

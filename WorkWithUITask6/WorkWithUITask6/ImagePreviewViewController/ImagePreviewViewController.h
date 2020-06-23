//
//  ImagePreviewViewController.h
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/23/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImagePreviewViewController : UIViewController
@property (nonatomic, strong) PHAsset *assetItem;
@end

NS_ASSUME_NONNULL_END

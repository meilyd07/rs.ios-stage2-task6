//
//  AssetCollectionCell.h
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/23/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface AssetCollectionCell : UICollectionViewCell
- (void)configureWithItem:(PHAsset *)item;
@end

NS_ASSUME_NONNULL_END

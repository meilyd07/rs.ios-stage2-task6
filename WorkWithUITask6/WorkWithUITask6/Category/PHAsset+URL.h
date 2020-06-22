//
//  PHAsset+URL.h
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/23/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (URL)
- (NSURL *)getFileURLFromPHAssetResourceDescription;
@end

NS_ASSUME_NONNULL_END

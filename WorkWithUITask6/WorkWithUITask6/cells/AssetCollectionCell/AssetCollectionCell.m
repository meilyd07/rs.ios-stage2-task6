//
//  AssetCollectionCell.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/23/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "AssetCollectionCell.h"

@interface AssetCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AssetCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithItem:(PHAsset *)item {
    
    switch (item.mediaType) {
        case PHAssetMediaTypeImage:
            [self setThumbnail:item];
            break;
        case PHAssetMediaTypeAudio:
            self.imageView.image = [UIImage imageNamed:@"audio_screen"];
            break;
        case PHAssetMediaTypeVideo:
             [self setThumbnail:item];
            break;
        default:
            self.imageView.image = [UIImage imageNamed:@"other_screen"];
            break;
    }
}

-(void)setThumbnail:(PHAsset *)item {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    NSInteger retinaMultiplier = [UIScreen mainScreen].scale;
    CGSize retinaSquare = CGSizeMake(self.imageView.bounds.size.width * retinaMultiplier, self.imageView.bounds.size.height * retinaMultiplier);
    
    [[PHImageManager defaultManager]
     requestImageForAsset:(PHAsset *)item
     targetSize:retinaSquare
     contentMode:PHImageContentModeAspectFill
     options:options
     resultHandler:^(UIImage *result, NSDictionary *info) {
        
        self.imageView.image =[UIImage imageWithCGImage:result.CGImage scale:retinaMultiplier orientation:result.imageOrientation];
        
    }];
}
@end

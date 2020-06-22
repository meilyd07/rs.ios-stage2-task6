//
//  InfoCell.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/21/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "InfoCell.h"

@interface InfoCell()
@property (weak, nonatomic) IBOutlet UIImageView *assetImage;
@property (weak, nonatomic) IBOutlet UILabel *assetName;
@property (weak, nonatomic) IBOutlet UIImageView *assetTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *assetDetailText;

@end

@implementation InfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithItem:(PHAsset *)item {
    self.assetName.text = [item valueForKey:@"filename"];
    
    switch (item.mediaType) {
        case PHAssetMediaTypeImage:
            [self setupImageCell:item];
            break;
        case PHAssetMediaTypeAudio:
            [self setupAudioCell:item];
            break;
        case PHAssetMediaTypeVideo:
            [self setupVideoCell:item];
            break;
        default:
            [self setupOther:item];
            break;
    }
}

-(void)setupOther:(PHAsset *)item {
    self.assetTypeImage.image = [UIImage imageNamed:@"other"];
    self.assetImage.image = [UIImage imageNamed:@"other_screen"];
    self.assetDetailText.text = @"";
}

-(void)setupVideoCell:(PHAsset *)item {
    self.assetTypeImage.image = [UIImage imageNamed:@"video"];
    self.assetDetailText.text = [NSString stringWithFormat:@"%lu x %lu %@", (unsigned long)item.pixelHeight, item.pixelWidth, [self stringFromTimeInterval:item.duration]];
    [self setThumbnail:item];
}

-(void)setThumbnail:(PHAsset *)item {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    NSInteger retinaMultiplier = [UIScreen mainScreen].scale;
    CGSize retinaSquare = CGSizeMake(self.assetImage.bounds.size.width * retinaMultiplier, self.assetImage.bounds.size.height * retinaMultiplier);
    
    [[PHImageManager defaultManager]
     requestImageForAsset:(PHAsset *)item
     targetSize:retinaSquare
     contentMode:PHImageContentModeAspectFill
     options:options
     resultHandler:^(UIImage *result, NSDictionary *info) {
        
        self.assetImage.image =[UIImage imageWithCGImage:result.CGImage scale:retinaMultiplier orientation:result.imageOrientation];
        
    }];
}

-(void)setupAudioCell:(PHAsset *)item {
    self.assetImage.image = [UIImage imageNamed:@"audio_screen"];
    self.assetTypeImage.image = [UIImage imageNamed:@"audio"];
    self.assetDetailText.text = [NSString stringWithFormat:@"%@", [self stringFromTimeInterval:item.duration]];
}

-(void)setupImageCell:(PHAsset *)item {
    //set icon
    self.assetTypeImage.image = [UIImage imageNamed:@"image"];
    self.assetDetailText.text = [NSString stringWithFormat:@"%lu x %lu", (unsigned long)item.pixelHeight, item.pixelWidth];
    
    [self setThumbnail:item];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval {
    NSInteger interval = timeInterval;
    long seconds = interval % 60;
    long minutes = (interval / 60) % 60;
    long hours = (interval / 3600);
    
    return  (hours < 1) ? [NSString stringWithFormat:@"%02ld:%02ld",  (long)minutes, (long)seconds] : [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}
@end

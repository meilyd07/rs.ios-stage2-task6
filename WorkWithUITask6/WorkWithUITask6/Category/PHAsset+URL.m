//
//  PHAsset+URL.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/23/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "PHAsset+URL.h"

@implementation PHAsset (URL)

- (NSURL *)getFileURLFromPHAssetResourceDescription {
    if (@available(iOS 11.0, *)) {
        NSURL *url = nil;
        
        NSArray<PHAssetResource *> *assetResources = [PHAssetResource assetResourcesForAsset:self];
        for (PHAssetResource *res in assetResources) {
            NSError *error = nil;
            NSString *pattern =@"(?<=fileURL: ).*(?=\\s)";
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
            
            NSTextCheckingResult *result =
            [regex firstMatchInString:res.debugDescription options:0 range:NSMakeRange(0, res.debugDescription.length)];
            NSString *string = [res.debugDescription substringWithRange:[result range]];
            
            url = [[NSURL alloc] initWithString:string];
            if (url != nil) {
                return url;
            }
            
        }
    } else {
        __block NSURL *url = nil;
        
        if (self.mediaType == PHAssetMediaTypeImage)
        {
            PHImageRequestOptions * imageRequestOptions = [[PHImageRequestOptions alloc] init];
            imageRequestOptions.synchronous = YES;
            [[PHImageManager defaultManager]
             requestImageDataForAsset:self
             options:imageRequestOptions
             resultHandler:^(NSData *imageData, NSString *dataUTI,
                             UIImageOrientation orientation,
                             NSDictionary *info) {
                if ([info objectForKey:@"PHImageFileURLKey"]) {
                    url = [info objectForKey:@"PHImageFileURLKey"];
                }
            }];
            return url;
        }
        else if (self.mediaType == PHAssetMediaTypeVideo)
        {
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            PHVideoRequestOptions *videoRequestOptions = [[PHVideoRequestOptions alloc]init];
            videoRequestOptions.version = PHVideoRequestOptionsVersionOriginal;
            videoRequestOptions.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
            videoRequestOptions.networkAccessAllowed = YES;
            [[PHImageManager defaultManager]
             requestAVAssetForVideo:self
             options:videoRequestOptions
             resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info)
            {
                if ([asset isKindOfClass:[AVURLAsset class]])
                {
                    url = [(AVURLAsset*)asset URL];
                    dispatch_semaphore_signal(semaphore);
                }
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            return url;
        }
    }
    return nil;
}
@end

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
    
    return url;
}
@end

#import "UIImage+imageNamed_bundle_.h"
#import <SSZipArchive.h>

@implementation UIImage (imageNamed_bundle_)

+ (NSString *)yf_sourcePatchKey{
    return @"SOURCE_PATCH";
}

+ (void)yf_updatePatchFrom:(NSString *) pathInfoUrlStr
{
    [self yf_fetchPatchInfo: pathInfoUrlStr
       completionHandler:^(NSDictionary *patchInfo, NSError *error) {
           if (error) {
               NSLog(@"fetchPatchInfo error: %@", error);
               return;
           }
           
           NSString * urlStr = [patchInfo objectForKey: @"url"];
           NSString * md5 = [patchInfo objectForKey:@"md5"];
           
           NSString * oriMd5 = [[[NSUserDefaults standardUserDefaults] objectForKey: [self yf_sourcePatchKey]] objectForKey:@"md5"];
           if ([oriMd5 isEqualToString:md5]) { // no update
               return;
           }
           
           [self yf_downloadFileFrom:urlStr completionHandler:^(NSURL *location, NSError *error) {
               if (error) {
                   NSLog(@"download file url:%@  error: %@", urlStr, error);
                   return;
               }
               
               NSString * patchCachePath = [self yf_cachePathFor: md5];
               [SSZipArchive unzipFileAtPath:location.path toDestination: patchCachePath overwrite:YES password:nil error:&error];
               
               if (error) {
                   NSLog(@"unzip and move file error, with urlStr:%@ error:%@", urlStr, error);
                   return;
               }
               
               /* update patch info. */
               NSString * source_patch_key = [self yf_sourcePatchKey];
               [[NSUserDefaults standardUserDefaults] setObject:patchInfo forKey: source_patch_key];
           }];
       }];

}

+ (NSString *)yf_relativeCachePathFor:(NSString *)md5
{
    return [@"patch" stringByAppendingPathComponent:md5];
}

+ (UIImage *)yf_imageNamed:(NSString *)imgName{
    NSString * bundleName = @"main";
    
    /* cache dir */
    NSString * md5 = [[[NSUserDefaults standardUserDefaults] objectForKey: [self yf_sourcePatchKey]] objectForKey:@"md5"];
    
    NSString * relativeCachePath = [self yf_relativeCachePathFor: md5];
    
    return [self yf_imageNamed: imgName bundle:bundleName cacheDir: relativeCachePath];
}

+ (UIImage *)yf_imageNamed:(NSString *)imgName bundle:(NSString *)bundleName cacheDir:(NSString *)cacheDir
{
    NSArray * LibraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    bundleName = [NSString stringWithFormat:@"%@.bundle",bundleName];
    
    NSString * ipaBundleDir = [NSBundle mainBundle].resourcePath;
    NSString * cacheBundleDir = ipaBundleDir;
    
    if (cacheDir) {
        cacheBundleDir = [[[LibraryPaths objectAtIndex:0] stringByAppendingFormat:@"/Caches"] stringByAppendingPathComponent:cacheDir];
    }
    
    imgName = [NSString stringWithFormat:@"%@@3x",imgName];
    
    NSString * bundlePath = [cacheBundleDir stringByAppendingPathComponent: bundleName];
    NSBundle * mainBundle = [NSBundle bundleWithPath:bundlePath];
    NSString * imgPath = [mainBundle pathForResource:imgName ofType:@"png"];
    
    /* try load from ipa! */
    if ( ! imgPath && ! [ipaBundleDir isEqualToString: cacheBundleDir]) {
        bundlePath = [ipaBundleDir stringByAppendingPathComponent: bundleName];
        mainBundle = [NSBundle bundleWithPath:bundlePath];
        imgPath = [mainBundle pathForResource:imgName ofType:@"png"];
    }
    
    UIImage * image;
    static NSString * model;
    
    if (!model) {
        model = [[UIDevice currentDevice]model];
    }
    
    if ([model isEqualToString:@"iPad"]) {
        NSData * imageData = [NSData dataWithContentsOfFile: imgPath];
        image = [UIImage imageWithData:imageData scale:2.0];
    }else{
        image = [UIImage imageWithContentsOfFile: imgPath];
    }
   
    return  image ;
}

+ (void)yf_fetchPatchInfo:(NSString *) urlStr completionHandler:(void (^)(NSDictionary * patchInfo, NSError * error))completionHandler
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        NSDictionary * patchInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];;
                                                        
                                                        completionHandler(patchInfo, error);
                                                    }];
    
    [dataTask resume];
}

+ (void) yf_downloadFileFrom:(NSString * ) urlStr completionHandler: (void (^)(NSURL *location, NSError * error)) completionHandler
{
    NSURL * url = [NSURL URLWithString:urlStr];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDownloadTask * downloadTask =[ defaultSession downloadTaskWithURL:url
                                                                completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
                                              {
                                                  
                                                  completionHandler(location,error);
                                                  
                                              }];
    [downloadTask resume];
}

+ (NSString *)yf_cachePathFor:(NSString * )patchMd5
{
    NSArray * LibraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString * cachePath = [[[LibraryPaths objectAtIndex:0] stringByAppendingFormat:@"/Caches"] stringByAppendingPathComponent:[self yf_relativeCachePathFor: patchMd5]];

    return cachePath;
}

@end

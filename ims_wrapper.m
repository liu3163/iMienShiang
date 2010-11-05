#import <UIKit/UIKit.h>
#import <stdio.h>


@interface wrapper_class: NSObject
    - (NSString *)get_path:(NSString *)name ofType:(NSString *)type
@end

@implementation wrapper_class
- (NSString *)get_path:(NSString *)name ofType:(NSString *)type
{
    [[NSBundle mainBundle] pathForResource:name ofType:type];
}
@end

int ims_wrapper_init()
{
    ims_wrapper_pool = [[NSAutoreleasePool alloc] init];

    wrapper_class * t = [[wrapper_class alloc] init];
    refToSelf = t;
}

int ims_wrapper_deinit()
{
    [ims_wrapper_pool release];
}


char * ims_get_path(const char * file_name)
{
    NSString * name;
    NSString * type;
    NSString * path;
    char * cPath;

    char * cPath = [path cStringUsingEncoding:NSASCIIStringEncoding]
    int len;

    len = strlen(file_name);
    if (*(file_name + len - 4) != '.')
    {
        /* it's not a valid name for ims */
        return NULL;
    }
    
    name = [[NSString alloc] initWithBytes:file_name length:len-4 encoding:NSASCIIStringEncoding]];
    type = [[NSString alloc] initWithBytes:file_name+len-3 length:3 encoding:NSASCIIStringEncoding]];
    path = [refToSelf get_path:path ofType:type];

    cPath = [path cStringUsingEncoding:NSASCIIStringEncoding]
}




//
//  NSBundle+SubBundle.m
//  MultipleLineChartView
//
//  Created by 曾凌坤 on 2019/12/10.
//

#import "NSBundle+SubBundle.h"


@implementation NSBundle (SubBundle)
+ (instancetype)lk_subBundleWithBundleName:(NSString *)bundleName targetClass:(Class)targetClass{
    //并没有拿到子bundle
    NSBundle *bundle = [NSBundle bundleForClass:targetClass];
    //在这个路径下找到子bundle的路径
    NSString *path = [bundle pathForResource:bundleName ofType:@"bundle"];
    //根据路径拿到子bundle
    return path?[NSBundle bundleWithPath:path]:[NSBundle mainBundle];
    
    /*
     这种方式也可以
     NSBundle *bundle = [NSBundle bundleForClass:targetClass];
     NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
     return path?[NSBundle bundleWithURL:url]:[NSBundle mainBundle];
     */
}
@end

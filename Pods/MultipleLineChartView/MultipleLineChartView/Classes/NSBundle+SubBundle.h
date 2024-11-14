//
//  NSBundle+SubBundle.h
//  MultipleLineChartView
//
//  Created by 曾凌坤 on 2019/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (SubBundle)
//bundleName是和组件名字一样的
+ (instancetype)lk_subBundleWithBundleName:(NSString *)bundleName targetClass:(Class)targetClass;
@end

NS_ASSUME_NONNULL_END

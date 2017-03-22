//
//  ZWCollectionCategoryModel.h
//  ZWTwoTableLinkage
//
//  Created by 郑亚伟 on 2017/3/10.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ZWSubCategoryModel.h"

@protocol ZWSubCategoryModel

@end

@interface ZWCollectionCategoryModel : JSONModel
@property(nonatomic,copy)NSString *name;
@property (nonatomic,strong) NSArray <ZWSubCategoryModel>*subcategories;

@end

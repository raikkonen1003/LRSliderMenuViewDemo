//
//  KYAInfoModel.h
//  KYAsset
//
//  Created by LR on 2017/12/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,copy) NSString *theme;
@property (nonatomic,copy) NSString *theme_img;
@property (nonatomic,strong) NSNumber *type;
@property (nonatomic,copy) NSString *add_time;
@property (nonatomic,copy) NSString *url;
@end

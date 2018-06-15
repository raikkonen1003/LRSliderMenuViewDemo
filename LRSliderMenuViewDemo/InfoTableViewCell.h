//
//  KYAInfoTableViewCell.h
//  KYAsset
//
//  Created by LR on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoModel.h"

@interface InfoTableViewCell : UITableViewCell

@property (nonatomic,strong) InfoModel *model;

- (NSAttributedString *)attributedStringWithFont:(UIFont *)font content:(NSString *)content;
- (CGFloat)contentHeightWithFont:(UIFont *)font text:(NSString *)text width:(CGFloat)width;
@end

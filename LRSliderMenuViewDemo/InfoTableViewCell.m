//
//  KYAInfoTableViewCell.m
//  KYAsset
//
//  Created by LR on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "Header.h"

@interface InfoTableViewCell()
@property (nonatomic,strong) UILabel *titleL;
@property (nonatomic,strong) UILabel *dateL;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;//虚线

@property (nonatomic,strong) NSMutableParagraphStyle *paraStyle;
@end

@implementation InfoTableViewCell

- (NSMutableParagraphStyle *)paraStyle {
    if (!_paraStyle) {
        _paraStyle = [[NSMutableParagraphStyle alloc] init];
        _paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        _paraStyle.alignment = NSTextAlignmentLeft;
        _paraStyle.lineSpacing = RESIZE(5); //设置行间距
        //        _paraStyle.hyphenationFactor = 1.0;
        //        _paraStyle.firstLineHeadIndent = 0.0;
        //        _paraStyle.paragraphSpacingBefore = 0.0;
        //        _paraStyle.headIndent = 0;
        //        _paraStyle.tailIndent = 0;
    }
    return _paraStyle;
}

- (NSAttributedString *)attributedStringWithFont:(UIFont *)font content:(NSString *)content {
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:self.paraStyle,
                          NSKernAttributeName:@0.0f
                          };
    if (!content) {
        content = @"";
    }
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:content
                                                                       attributes:dic];
    return attributeStr;
}

- (CGFloat)contentHeightWithFont:(UIFont *)font text:(NSString *)text width:(CGFloat)width {
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:self.paraStyle,
                          NSKernAttributeName:@0.0f
                          };
    CGFloat height = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:dic
                                        context:nil].size.height;
    return height;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createView];
        
    }
    return self;
}

- (void)createView {
    UILabel *titleL = [[UILabel alloc]init];
    UIFont *font = [UIFont cy_PingFangSC_RegularFontOfSize:RESIZE(14)];//[UIFont fontWithName:PingFangSC_Regular size:RESIZE(14)];
    titleL.textColor = COLOR_WITH_HEX(0x434C5D, 1.0);
    NSString *str = @"契约型私募基金";
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:font}];
//    CGFloat typeLWidth = size.width + RESIZE(10);
    CGFloat typeLHeight = size.height;
    titleL.frame = CGRectMake(RESIZE(20), RESIZE(20), SCREEN_WIDTH-2*RESIZE(20), typeLHeight);
    titleL.font = font;
//    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.numberOfLines = 0;
    [self.contentView addSubview:titleL];
    _titleL = titleL;
    
    UILabel *dateL = [[UILabel alloc]init];
    UIFont *dateLFont = [UIFont cy_PingFangSC_RegularFontOfSize:RESIZE(12)];//[UIFont fontWithName:PingFangSC_Regular size:RESIZE(12)];
    dateL.textColor = COLOR_WITH_HEX(0x959DAA, 1.0);
    CGSize dateLSize = [str sizeWithAttributes:@{NSFontAttributeName:dateLFont}];
//    CGFloat dateLWidth = dateLSize.width + RESIZE(10);
    CGFloat dateLHeight = dateLSize.height;
    dateL.frame = CGRectMake(RESIZE(20), CGRectGetMaxY(titleL.frame)+RESIZE(10), SCREEN_WIDTH-2*RESIZE(20), dateLHeight);
    dateL.font = dateLFont;
    [self.contentView addSubview:dateL];
    _dateL = dateL;
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.frame = CGRectMake(RESIZE(20), CGRectGetMaxY(_dateL.frame)+RESIZE(10), SCREEN_WIDTH-2*RESIZE(20), 1);
    [self.contentView addSubview:bottomLine];
    _bottomLine = bottomLine;
    
    [self drawDashLine:_bottomLine lineLength:3 lineSpacing:1 lineColor:COLOR_WITH_HEX(0xE3E3E3, 1.0)];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    CGSize size = [_titleL sizeThatFits:CGSizeMake(_titleL.bounds.size.width, CGFLOAT_MAX)];
//    CGSize size = [_titleL.text sizeWithAttributes:@{NSFontAttributeName:_titleL.font}];
//    CGSize size = [_titleL.text boundingRectWithSize:CGSizeMake(_titleL.bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_titleL.font} context:nil].size;
    CGFloat typeLWidth = SCREEN_WIDTH-2*RESIZE(20);
    CGFloat typeLHeight = [self contentHeightWithFont:_titleL.font text:_titleL.attributedText.string width:typeLWidth];
    _titleL.frame = CGRectMake(RESIZE(20), RESIZE(20), typeLWidth, typeLHeight);
    
    CGSize dateLSize = [_dateL.text sizeWithAttributes:@{NSFontAttributeName:_dateL.font}];
    //    CGFloat dateLWidth = dateLSize.width + RESIZE(10);
    CGFloat dateLHeight = dateLSize.height;
    _dateL.frame = CGRectMake(RESIZE(20), CGRectGetMaxY(_titleL.frame)+RESIZE(10), SCREEN_WIDTH-2*RESIZE(20), dateLHeight);
    
    _bottomLine.frame = CGRectMake(RESIZE(20), CGRectGetMaxY(_dateL.frame)+RESIZE(10), SCREEN_WIDTH-2*RESIZE(20), 1);
}

- (void)setModel:(InfoModel *)model {
    _model = model;
    
//    _titleL.text = model.theme;
    _titleL.attributedText = [self attributedStringWithFont:_titleL.font content:model.theme];
    _dateL.text = model.add_time;
    
    [self layoutIfNeeded];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, CGRectGetMaxY(_bottomLine.frame));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/*
 * lineView:       需要绘制成虚线的view
 * lineLength:     虚线的宽度
 * lineSpacing:    虚线的间距
 * lineColor:      虚线的颜色
 */
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    _shapeLayer = [CAShapeLayer layer];
    [_shapeLayer setBounds:lineView.bounds];
    [_shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [_shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [_shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [_shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [_shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [_shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [_shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:_shapeLayer];
}


@end

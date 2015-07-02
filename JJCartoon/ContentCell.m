//
//  ContentCell.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/30.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "ContentCell.h"
#define kHeadImageWidth 100
#define kHeadImageHeight 80
#define kInspace 10
#define kTitleLabelWidth 230
#define kLabelHeight 30
#define kDateWidth 50
#define kLikeWidth 100

@implementation ContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void) addSubviews
{
    // 设置 headImage
    self.headImage = [[EGOImageView alloc]init];
    self.headImage.frame = CGRectMake(10, 10, kHeadImageWidth, kHeadImageHeight);
    [self addSubview:self.headImage];
      // 设置 titleLabel
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.frame.origin.x + self.headImage.frame.size.width + kInspace, self.headImage.frame.origin.y, kTitleLabelWidth, kLabelHeight)];
//    self.titleLabel.text = self.model.title;
    [self addSubview:self.titleLabel];
      // 设置 titleLabel
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + kLabelHeight + kInspace, kDateWidth, kLabelHeight)];
    [self addSubview:self.dateLabel];
      // 设置 titleLabel
    self.likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.dateLabel.frame.origin.x + kDateWidth + 5*kInspace, self.dateLabel.frame.origin.y, kLikeWidth, kLabelHeight)];
    [self addSubview:self.likeLabel];
    
}
-(void)dealloc
{
    _dateLabel = nil;
    _headImage = nil;
    _titleLabel = nil;
    _likeLabel = nil;
    [super dealloc];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

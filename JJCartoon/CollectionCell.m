//
//  CollectionCell.m
//  JJCartoon
//
//  Created by lanouhn on 15/6/25.
//  Copyright (c) 2015年 Mr.xie. All rights reserved.
//

#import "CollectionCell.h"
#import "EGOImageView.h"
@implementation CollectionCell

// 对photoImage 进行懒加载
-(EGOImageView *)photoImage
{
    if (!_photoImage) {
        self.photoImage = [[EGOImageView alloc]initWithFrame:self.contentView.bounds];
        _photoImage.placeholderImage = [UIImage imageNamed:@"imagetitle"];
        [self.contentView addSubview:_photoImage];
        [_photoImage release];
    }
    return _photoImage;
}
// 对titleLabel 进行懒加载
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc]init];
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.contentView.bounds.size.height - 30, self.contentView.bounds.size.width, 30)];
        toolBar.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:toolBar];
        self.titleLabel.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, 30);
        [toolBar addSubview:_titleLabel];
        [_titleLabel release];
        [toolBar release];
    }
    return _titleLabel;
    
}
-(void)dealloc
{
    [_titleLabel release];
    [_photoImage release];
    [super dealloc];
    
}

@end

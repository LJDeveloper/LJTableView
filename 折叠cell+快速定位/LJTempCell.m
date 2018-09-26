//
//  LJTempCell.m
//  折叠cell+快速定位
//
//  Created by 莱尔夫 on 2018/7/19.
//  Copyright © 2018年 莱尔夫. All rights reserved.
//

#import "LJTempCell.h"
@implementation LJTempCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(UILabel *)lable
{
    if (!_lable){
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 44)];
//        _lable.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [self.contentView addSubview:_lable];
    }
    return _lable;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

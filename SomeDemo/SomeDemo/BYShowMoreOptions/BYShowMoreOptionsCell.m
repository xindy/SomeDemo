//
//  BYShowMoreOptionsCell.m
//  SomeDemo
//
//  Created by xindy on 2017/7/26.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import "BYShowMoreOptionsCell.h"

@interface BYShowMoreOptionsCell ()

//图标
@property (nonatomic, strong) UIImageView *iconImageView;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//分割线
@property (nonatomic, strong) UIView *separatorLineView;

@end


@implementation BYShowMoreOptionsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addSubViews {
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.separatorLineView];
}


//optionDict[@"imageName":,@"title":]
- (void)refreshWithOptionDict:(NSDictionary *)optionDict showSeparatorLine:(BOOL)toShow {
    
    [self.iconImageView setImage:[UIImage imageNamed:[optionDict objectForKey:@"imageName"]]];
    [self.titleLabel setText:[optionDict objectForKey:@"title"]];
    
    if (toShow) {
        [self.separatorLineView setHidden:NO];
    }
    else {
        [self.separatorLineView setHidden:YES];
    }
}


#pragma mark - 懒加载

//图标
- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 11, 22, 22)];
    }
    
    return _iconImageView;
}

//标题
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 70, 44)];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    
    return _titleLabel;
}

//分割线
- (UIView *)separatorLineView {
    
    if (!_separatorLineView) {
        
        _separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, SCREEN_WIDTH, 0.5)];
        [_separatorLineView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0]];
    }
    
    return _separatorLineView;
}



@end

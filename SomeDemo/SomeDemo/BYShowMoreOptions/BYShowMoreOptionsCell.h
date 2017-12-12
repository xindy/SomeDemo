//
//  BYShowMoreOptionsCell.h
//  SomeDemo
//
//  Created by xindy on 2017/7/26.
//  Copyright © 2017年 xindylin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYShowMoreOptionsCell : UITableViewCell

//optionDict[@"imageName":,@"title":,@"isSelected":,@"selectedImageName":,@"selectedTitle":]
- (void)refreshWithOptionDict:(NSDictionary *)optionDict showSeparatorLine:(BOOL)toShow;


@end

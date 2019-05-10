//
//  DCMeCell.m
//  百思不得姐
//
//  Created by 大橙子 on 2019/2/15.
//  Copyright © 2019 Tomous. All rights reserved.
//

#import "DCMeCell.h"

@implementation DCMeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.y = DCSmallMargin;
    self.imageView.height = self.contentView.height - DCSmallMargin*2;
    self.imageView.width = self.imageView.height;
    
    self.textLabel.x = self.imageView.right + DCMargin;
}

@end

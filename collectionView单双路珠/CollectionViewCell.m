//
//  CollectionViewCell.m
//  澳静乐所需
//
//  Created by IMAC on 2017/3/2.
//  Copyright © 2017年 小四. All rights reserved.
//

#import "CollectionViewCell.h"
@interface CollectionViewCell()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel    *label;
@end

@implementation CollectionViewCell
- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:self.bounds];
        _textView.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        _textView.textAlignment = NSTextAlignmentCenter;
        _textView.font = [UIFont systemFontOfSize:17];
        _textView.userInteractionEnabled = NO;
        _textView.textColor = [UIColor redColor];
        [_textView setContentInset:UIEdgeInsetsMake(-8, 0, 0, 0)];
        [self.contentView addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc]init];
        _label.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        _label.textAlignment = NSTextAlignmentRight;
        _label.font = [UIFont systemFontOfSize:17];
        _label.userInteractionEnabled = NO;
        _label.textColor = [UIColor redColor];
        [self.contentView addSubview:_label];
    }
    return _label;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 
    }
    return self;
}

- (void)refresh:(NSString *)title andcellHeight:(CGFloat)cellHeight direction:(DirectionStyle)direction{
 
    CGRect frame;
    CGFloat h                = self.bounds.size.height;
    CGRect lastframe         = self.bounds;
    lastframe.size.height    = cellHeight;
    
    if (direction == VerticalStyle) {
        
        self.textView.text   = title;
        self.textView.frame  = lastframe;
        
    }else{
        
        self.label.text      = title;
        frame.origin.x       = -h/3;
        frame.origin.y       = h/3;
        frame.size.width     = h;
        frame.size.height    = 30;
        self.label.frame     = frame;
        //旋转90度
        self.label.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        self.label.frame     = lastframe;

    }

}
@end

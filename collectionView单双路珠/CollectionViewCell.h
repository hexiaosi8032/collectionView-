//
//  CollectionViewCell.h
//  澳静乐所需
//
//  Created by IMAC on 2017/3/2.
//  Copyright © 2017年 小四. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    VerticalStyle ,//文字垂直方向展示
    RotationHorizontalStyle,//文字旋转展示
} DirectionStyle;//文字方向

@interface CollectionViewCell : UICollectionViewCell

- (void)refresh:(NSString *)title andcellHeight:(CGFloat)cellHeight direction:(DirectionStyle)direction;

@end

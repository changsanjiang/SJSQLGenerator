//
//  CollectionViewCell.m
//  SQLDemo
//
//  Created by BlueDancer on 2018/6/20.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell {
    UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _setupView];
    return self;
}

- (void)setText:(id)text {
    _text = text;
    _titleLabel.text = [NSString stringWithFormat:@"%@", text];
}

- (void)_setupView {
    _titleLabel = [UILabel new];
    _titleLabel.layer.borderColor = UIColor.blackColor.CGColor;
    _titleLabel.layer.borderWidth = .6;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = true;
    [_titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = true;
    [_titleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = true;
    [_titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = true;
}

@end

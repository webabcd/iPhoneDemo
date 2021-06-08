//
//  WPageViewContentController.m
//  iPhone
//
//  Created by iMac on 1/14/14.
//  Copyright (c) 2014 webabcd. All rights reserved.
//

#import "WPageViewContentController.h"

@interface WPageViewContentController ()


@end

@implementation WPageViewContentController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.label = [[UILabel alloc] initWithFrame:self.view.frame];
    self.label.textColor = [UIColor blueColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = self.displayString;
    
    [self.view addSubview:self.label];
}

@end

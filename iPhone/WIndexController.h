//
//  WIndexController.h
//  iPhone
//
//  Created by iMac on 9/26/13.
//  Copyright (c) 2013 webabcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WIndexController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSDictionary *items;
@property (strong, nonatomic) NSArray *groups;

@end

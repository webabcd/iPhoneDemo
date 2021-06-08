//
//  WAutoreleasepoolController.m
//  iPhone
//
//  Created by wanglei on 5/18/15.
//  Copyright (c) 2015 webabcd. All rights reserved.
//

#import "WAutoreleasepoolController.h"

#include <mach/mach.h>

@interface WAutoreleasepoolController ()

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end

@implementation WAutoreleasepoolController

double getMemoryUsage(void);

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.lblMsg setNumberOfLines:0];
    self.lblMsg.text = @"";

    dispatch_queue_t  serialQueue = dispatch_queue_create("abc", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(serialQueue, ^
                  {
                      for (int i=0; i<1000000;i++)
                      {
                          @autoreleasepool {
                              NSString *str =  [ NSString stringWithFormat:@"sdfas%@", @"sdfadsf"];
                              [ NSString stringWithFormat:@"sdfas%@", str];
                              
                              if (i % 10000 == 0)
                              {
                                  printf("%f\n", getMemoryUsage());
                              }
                              
                          }
                          
                      }
                  });

}

double getMemoryUsage(void)
{
    struct task_basic_info info;
    mach_msg_type_number_t size  = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    
    double memoryUsageInMB = kerr == KERN_SUCCESS ? (info.resident_size / 1024.0 / 1024.0) : 0.0;
    
    return memoryUsageInMB;
}

@end

//
//  iMienShiangAppDelegate.h
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "settingController.h"

@interface iMienShiangAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	settingController * controller;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet settingController * controller;

@end


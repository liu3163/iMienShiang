//
//  ageSettingController.h
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ageSettingControllerDelegate;


@interface ageSettingController : UIViewController {
	id <ageSettingControllerDelegate>  delegate;
	NSInteger activeRow;
	UIPickerView * agePicker;
	NSMutableArray * ageArray;
	
}

@property (nonatomic, assign) id <ageSettingControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIPickerView * agePicker;
@property (nonatomic, retain) IBOutlet NSMutableArray * ageArray;
@property (nonatomic) IBOutlet NSInteger activeRow;

- (IBAction)Cancel:(id)sender;

@end

@protocol ageSettingControllerDelegate
- (void)ageSettingControllerDidFinishSetting:(ageSettingController *)controller;
@end




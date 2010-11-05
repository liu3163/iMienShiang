//
//  raceSettingController.h
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol raceSettingControllerDelegate;

@interface raceSettingController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
	id <raceSettingControllerDelegate>  delegate;
	NSInteger activeRow;
	UIPickerView * racePicker;
	NSMutableArray * raceArray;

}

@property (nonatomic, assign) id <raceSettingControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIPickerView * racePicker;
@property (nonatomic, retain) IBOutlet NSMutableArray * raceArray;
@property (nonatomic) IBOutlet NSInteger activeRow;

- (IBAction)Cancel:(id)sender;

@end

@protocol raceSettingControllerDelegate
- (void)raceSettingControllerDidFinishSetting:(raceSettingController *)controller;
@end

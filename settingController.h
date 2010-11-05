//
//  settingController.h
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "raceSettingController.h"
#import "ageSettingController.h"
#import "analysisController.h"


@interface settingController : UIViewController 
   <raceSettingControllerDelegate, ageSettingControllerDelegate, analysisControllerDelegate>
{
	UITextField * ageText;
	UITextField * raceText;
	UIButton * startButton;
	UIButton * ageSettingButton;
	UIButton * raceSettingButton;

}

@property (nonatomic, retain) IBOutlet UITextField * ageText;
@property (nonatomic, retain) IBOutlet UITextField * raceText;
@property (nonatomic, retain) IBOutlet UIButton * startButton;
@property (nonatomic, retain) IBOutlet UIButton * ageSettingButton;
@property (nonatomic, retain) IBOutlet UIButton * raceSettingButton;



-(IBAction)setRace:(id)sender;
-(IBAction)setAge:(id)sender;
-(IBAction)setGener:(id)sender;
-(IBAction)startAnalysis:(id)sender;

@end

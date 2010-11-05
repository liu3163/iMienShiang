//
//  photoAddingController.h
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol photoAddingControllerDelegate;

@interface photoAddingController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
	id <photoAddingControllerDelegate>  delegate;

}

@property (nonatomic, assign) id <photoAddingControllerDelegate> delegate;

- (IBAction)addFromLibrary:(id)sender;
- (IBAction)addFromCamera:(id)sender;
- (IBAction)Cancel:(id)sender;

@end

@protocol photoAddingControllerDelegate
-(void) photoAddingControllerDidFinishingSetting:(photoAddingController *)controller;

@end

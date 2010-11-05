//
//  raceSettingController.m
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "raceSettingController.h"


@implementation raceSettingController

@synthesize delegate;
@synthesize racePicker;
@synthesize raceArray;
@synthesize activeRow;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		racePicker = [[UIPickerView alloc] init];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	raceArray = [[NSMutableArray alloc] init];
	[raceArray addObject:@"White-Caucasian"];
	[raceArray addObject:@"Yellow-Mongoloid"];
	[raceArray addObject:@"Black-Negro"];
	[raceArray addObject:@"Brown-Australian"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [raceArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	return [raceArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	activeRow = row;
	[self.delegate raceSettingControllerDidFinishSetting:self];		
}

- (IBAction)Cancel:(id)sender {
	[self.delegate raceSettingControllerDidFinishSetting:self];	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[raceArray dealloc];

	raceArray = nil;

    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end

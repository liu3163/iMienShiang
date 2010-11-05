//
//  ageSettingController.m
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ageSettingController.h"


@implementation ageSettingController

@synthesize delegate;
@synthesize agePicker;
@synthesize ageArray;
@synthesize activeRow;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	ageArray = [[NSMutableArray alloc] init];
	[ageArray addObject:@"1"];
	[ageArray addObject:@"2"];
	[ageArray addObject:@"3"];
	[ageArray addObject:@"4"];
	[ageArray addObject:@"5"];
	[ageArray addObject:@"6"];
	[ageArray addObject:@"7"];
	[ageArray addObject:@"8"];
	[ageArray addObject:@"9"];
	[ageArray addObject:@"10"];
	[ageArray addObject:@"11"];
	[ageArray addObject:@"12"];
	[ageArray addObject:@"13"];
	[ageArray addObject:@"14"];
	[ageArray addObject:@"15"];
	[ageArray addObject:@"16"];
	[ageArray addObject:@"17"];
	[ageArray addObject:@"18"];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [ageArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	return [ageArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	activeRow = row;
	[self.delegate ageSettingControllerDidFinishSetting:self];		
}

- (IBAction)Cancel:(id)sender {
	[self.delegate ageSettingControllerDidFinishSetting:self];	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[ageArray dealloc];
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

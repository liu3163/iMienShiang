//
//  settingController.m
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "settingController.h"


@implementation settingController

@synthesize ageText;
@synthesize raceText;
@synthesize startButton;
@synthesize ageSettingButton;
@synthesize raceSettingButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)setRace:(id)sender
{
	raceSettingController * controller = [[raceSettingController alloc] init];
	controller.delegate = self;
	
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

-(IBAction)setAge:(id)sender
{
	ageSettingController * controller = [[ageSettingController alloc] init];
	controller.delegate = self;
	
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

-(IBAction)setGener:(id)sender
{
	
}

-(IBAction)startAnalysis:(id)sender
{
	analysisController * controller = [[analysisController alloc] init];
	controller.delegate = self;
	[self presentModalViewController:controller animated:YES];
	[controller release];
}


- (void)raceSettingControllerDidFinishSetting:(raceSettingController *)controller
{
	[raceText setText:[[controller raceArray] objectAtIndex:[controller activeRow]]];
	[self dismissModalViewControllerAnimated:YES];
} // end method finishedAdding

- (void)ageSettingControllerDidFinishSetting:(ageSettingController *)controller
{
	[ageText setText:[[controller ageArray] objectAtIndex:[controller activeRow]]];
	[self dismissModalViewControllerAnimated:YES];
} // end method finishedAdding


-(void) analysisControllerDidFinishingSetting:(analysisController *)controller
{
	[self dismissModalViewControllerAnimated:YES];
}



- (void)dealloc {
    [super dealloc];
}


@end

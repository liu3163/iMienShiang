//
//  photoAddingController.m
//  iMienShiang
//
//  Created by hong liu on 10-10-25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "photoAddingController.h"


@implementation photoAddingController

@synthesize delegate;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)addFromLibrary:(id)sender
{
	UIImagePickerControllerSourceType sourceType;
	
	sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.sourceType = sourceType;
	picker.delegate = self;
	[self presentModalViewController:picker animated:YES];
	[picker release];
}

- (IBAction)addFromCamera:(id)sender
{
	UIImagePickerControllerSourceType sourceType;
	sourceType = UIImagePickerControllerSourceTypeCamera;
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.sourceType = sourceType;
	picker.delegate = self;
	[self presentModalViewController:picker animated:YES];
	[picker release];
	
}


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

-(void)Cancel:(id)sender
{
	[self.delegate photoAddingControllerDidFinishingSetting:self];	
}


- (void)dealloc {
    [super dealloc];
}


@end

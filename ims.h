/*
 *  ims.h
 *  iMienShiang
 *
 *  Created by hong liu on 10-10-31.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef _IMS_
#define _IMS_
#include <opencv/cv.h>

/* whether each feature should be tagged to one photo? */
typedef struct _ims_features
{
	/* */
	IplImage * frontImage;
	IplImage * leftImage;
	IplImage * rightImage;
	
	/* Eye feature */
	CvPoint left_eye_left_point;
	CvPoint left_eye_right_point;
	CvPoint right_eye_left_point;
	CvPoint right_eye_right_poiont;
	CvPoint left_iris_left_point;
	CvPoint left_iris_right_point;
	CvPoint right_iris_left_point;
	CvPoint right_iris_right_point;
	
	/* Nose area */
	CvPoint left_nosewinge_border;
	CvPoint right_nosewing_border;
	CvPoint left_nosetip_border;
	CvPoint right_nosetip_border;
	CvPoint center_nose;
	
	/* */
	int philtrum_length;
	int philtrum_width;
	int philtrum_height;
	
	/* mouth area */
	CvPoint left_mouth_corner;
	CvPoint right_mouth_corner;
	int upper_lip_height;
	int lower_lip_height;
	
	/* Chin area */
	CvPoint chin_central_point;
	
	/* Ear area */
	CvPoint left_ear_up_point;
	CvPoint left_ear_low_point;
	CvPoint left_earlobe_up_point;
	CvPoint right_earlobe_up_poin;
	
}ims_features;

int ims_init();
int ims_deinit();
int ims_alloc();
int ims_dealloc();
int ims_add_photo();
int ims_remove_photo();
int ims_analysis(IplImage * image);

#endif


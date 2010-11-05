/*
 *  ims.c
 *  iMienShiang
 *
 *  Created by hong liu on 10-10-31.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#include "ims.h"
#include "ims_wrapper.h"

int ims_init()
{
    return 0;
}


int ims_deinit()
{
    return 0;
}


int ims_alloc()
{
    return 0;
}


int ims_dealloc()
{
    return 0;
}


int ims_add_photo()
{
    return 0;
}


int ims_remove_photo()
{
    return 0;
}


int ims_analysis(IplImage * image)
{
    return 0;
}

IplImage * ims_clip_left_image(IplImage * image)
{
    return NULL;
}

IplImage * ims_clip_right_image(IplImage * image)
{
    return NULL;
}

IplImage * ims_clip_front_image(IplImage * image)
{
    char * classifier_name = "haarcascade_frontalface_default.xml";
    char * classifier_path = NULL;

    cvSetErrMode(CV_ErrModeParent);

    // Load XML
    classifier_path = ims_get_path(classifier_name);
    CvHaarClassifierCascade* cascade = (CvHaarClassifierCascade*)cvLoad(classifier_path, NULL, NULL, NULL);
    CvMemStorage* storage = cvCreateMemStorage(0);

    // Detect faces and draw rectangle on them
    CvSeq* faces = cvHaarDetectObjects(image, cascade, storage, 1.2f, 2, CV_HAAR_DO_CANNY_PRUNING, cvSize(20, 20));

	if (1 != faces->total)
	{
		return NULL;
	}
	else 
	{
		// Calc the rect of faces
		CvRect cvrect = *(CvRect*)cvGetSeqElem(faces, 0);
		cvSetImageROI(image, cvrect);
		IplImage * clip_image = cvCreateImage(cvGetSize(image), image->depth, image->nChannels);
		cvCopy(image, clip_image, NULL);
	}

    cvReleaseMemStorage(&storage);
    cvReleaseHaarClassifierCascade(&cascade);
}








#import "YMVData.h"


@implementation YMVData

@synthesize dataTitle;
@synthesize dataId;
@synthesize dataPilot,dataPosterRef,dataRated ;


- (id)initWithTitle:(NSString *)theTitle andId:(NSString *)theId {
	self.dataTitle = theTitle;
	self.dataId = theId;
	
	return self;
}


@end

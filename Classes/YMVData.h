
#import <Foundation/Foundation.h>

@interface YMVData : NSObject {
	NSString *dataTitle;
	NSString *dataId;
    
    NSString *dataPilot ;
    NSString *dataRated ;
    NSString *dataPosterRef ;
}

@property (nonatomic, retain) NSString *dataTitle;
@property (nonatomic, retain) NSString *dataId;
@property (nonatomic, retain) NSString *dataPilot;
@property (nonatomic, retain) NSString *dataRated;
@property (nonatomic, retain) NSString *dataPosterRef;

- (id)initWithTitle:(NSString *)theTitle andId:(NSString *)theId;

@end

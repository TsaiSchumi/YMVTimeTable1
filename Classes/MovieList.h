

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "YMVData.h"


@interface MovieList : NSObject {
	NSMutableArray *movieList;
	NSMutableArray *areaList;
	NSMutableArray *cinemaList;
	
	NSInteger selectedMovie;
	NSInteger selectedArea;
	NSInteger selectedCinema;
	NSString * selectedImgURL ;
	NSString * selectedDetail ;
	NSString * expected ;
	NSMutableArray * NmovieList ;
	NSString * MovieLength ;
	NSString * ReleaseDate ;
}

@property (nonatomic, retain) NSMutableArray *movieList;
@property (nonatomic, retain) NSMutableArray *areaList;
@property (nonatomic, retain) NSMutableArray *cinemaList;
@property (nonatomic) NSInteger selectedMovie;
@property (nonatomic) NSInteger selectedArea;
@property (nonatomic) NSInteger selectedCinema;
@property (readwrite,retain) NSString *selectedImgURL ;
@property (readwrite,retain) NSString *selectedDetail ;
@property (readwrite,retain) NSString * expected ;
@property (nonatomic,retain) NSMutableArray * NmovieList ;
@property (nonatomic,retain) NSString * MovieLength ;
@property (nonatomic,retain) NSString * ReleaseDate ;



+ (MovieList*)sharedMovieList;
- (void)fetchMovieList;
- (void)fetchDetail2:(NSString*) movieID ;


@end

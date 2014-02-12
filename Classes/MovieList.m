

#import "MovieList.h"

@implementation MovieList

@synthesize movieList,areaList,cinemaList;
@synthesize selectedMovie,selectedArea,selectedCinema;
@synthesize selectedImgURL ,selectedDetail ,expected ,NmovieList ,MovieLength,ReleaseDate ;


SYNTHESIZE_SINGLETON_FOR_CLASS(MovieList);


- (void)dealloc {
	[movieList release];
	[areaList release];
	[cinemaList release];
	[NmovieList release];

	[super dealloc];
}

- (id)init {

	NSMutableArray *moviesArray = [[NSMutableArray alloc] init];
	self.movieList = moviesArray;
	[moviesArray release];
	NSMutableArray *areasArray = [[NSMutableArray alloc] init];
	self.areaList = areasArray;
	[areasArray release];
	NSMutableArray *cinemasArray = [[NSMutableArray alloc] init];
	self.cinemaList = cinemasArray;
	[cinemasArray release];
	NSMutableArray *nmoviesArray = [[NSMutableArray alloc] init];
	self.NmovieList = nmoviesArray;
	[nmoviesArray release];
	
	return self;
}


- (void)fetchMovieList {
	
	
	NSStringEncoding theEncoding;
	NSError *theError = nil;
    NSString *urlString =  [[NSString alloc] initWithUTF8String:"http://movies.io/m/search?utf8=/%E2/%9C/%93&q=hobbies"];
    
	NSURL *theUrl = [NSURL URLWithString:urlString];
	NSString *urlContent = [NSString stringWithContentsOfURL:theUrl usedEncoding:&theEncoding error:&theError];
	[urlString release];
	if (theError) {
		NSLog(@"%@", theError);
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UIAlertView" message:@"Please make sure your internet connection is alright." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
		[alert show];
		[alert release];
		return;
	}

    NSArray *values = [urlContent componentsSeparatedByString:@"</a>"];
     
    
    for (int i=2; i<[values count]; i++) {
        NSString* tempContent = [values objectAtIndex:i];
        YMVData* movie = [self parseMovieNameAndID:tempContent];
        [movieList addObject:movie];
    }
    [movieList removeObjectAtIndex:0];

}








-(void)fetchDetail2:(NSString*) movieID
{
    NSString* sURL = [NSString stringWithFormat:@"http://movies.io/m/%@/en",movieID];
	NSStringEncoding theEncoding;
	NSURL *theUrl = [NSURL URLWithString:sURL];
	NSString *urlContent = [NSString stringWithContentsOfURL:theUrl usedEncoding:&theEncoding error:nil];
    YMVData *detailData = [self parseMovieDetail:urlContent];
	

	self.selectedImgURL = detailData.dataPosterRef ;

	self.selectedDetail=detailData.dataPilot ;

	self.expected = detailData.dataRated ;
}



- (YMVData*)parseMovieNameAndID :(NSString*)html {
    NSError *error = nil;
    NSString* title ;
    NSString* theID ;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    YMVData* data = [[YMVData alloc]init];
    
    if (error) {
        NSLog(@"Error: %@", error);
        [parser release];
        return [data autorelease] ;
    }
    
    HTMLNode *bodyNode = [parser body];
    
    NSArray *inputNodes = [bodyNode findChildTags:@"div"];
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"<>\n"];
    
    for (HTMLNode *inputNode in inputNodes) {
        if ([[inputNode getAttributeNamed:@"class"] isEqualToString:@"search-title"]) {
            
            NSString* temp = [[[inputNode rawContents] componentsSeparatedByCharactersInSet:charSet] objectAtIndex:3];
            title = [temp stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            data.dataTitle = title ;
        }
    }
    
    
    NSArray *liNodes = [bodyNode findChildTags:@"li"];
    for (HTMLNode *liNode in liNodes) {
        if ([[liNode getAttributeNamed:@"class"] isEqualToString:@"search-result"]) {
            theID = [liNode getAttributeNamed:@"data-movie-bid"] ;
            data.dataId = theID ;
        }
    }

    [parser release];
    return [data autorelease] ;
}



- (YMVData*)parseMovieDetail : (NSString*)html {
    NSError *error = nil;
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    YMVData* data = [[YMVData alloc]init];
    
    if (error) {
        NSLog(@"Error: %@", error);
        [parser release];
        return [data autorelease] ;
    }
    
    HTMLNode *bodyNode = [parser body];
    
    NSArray *imgNodes = [bodyNode findChildTags:@"img"];
    for (HTMLNode *imgNode in imgNodes) {
        if ([[imgNode getAttributeNamed:@"class"] isEqualToString:@"movie_poster"]) {
            data.dataPosterRef = [imgNode getAttributeNamed:@"src"] ;
        }
    }

    
    NSArray *rateNodes = [bodyNode findChildTags:@"span"];
    for (HTMLNode *rateNode in rateNodes) {
        if ([[rateNode getAttributeNamed:@"class"] isEqualToString:@"movie_rating_value"]) {
            data.dataRated = [[rateNode contents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
    }
    
    NSArray *contentNodes = [bodyNode findChildTags:@"div"];
    for (HTMLNode *contentNode in contentNodes) {
        if ([[contentNode getAttributeNamed:@"class"] isEqualToString:@"movie_plot"]) {
            NSString* moviePilot =[[contentNode contents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ( moviePilot && [moviePilot length]>0) {
                data.dataPilot = moviePilot ;
            }
            else {
                NSString* moviePilot =[contentNode rawContents];
                NSCharacterSet *cSet = [NSCharacterSet characterSetWithCharactersInString:@"<>\n"];
                data.dataPilot = [[moviePilot componentsSeparatedByCharactersInSet:cSet] objectAtIndex:5];
            }
        }
    }

    
    
    [parser release];
    return [data autorelease] ;
}


@end

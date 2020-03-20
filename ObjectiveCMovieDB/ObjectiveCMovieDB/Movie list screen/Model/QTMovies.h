// To parse this JSON:
//
//   NSError *error;
//   QTMovies *movies = [QTMovies fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTMovies;
@class QTDates;
@class QTResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface QTMovies : NSObject
@property (nonatomic, copy)   NSArray<QTResult *> *results;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalResults;
@property (nonatomic, strong) QTDates *dates;
@property (nonatomic, assign) NSInteger totalPages;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTDates : NSObject
@property (nonatomic, copy) NSString *maximum;
@property (nonatomic, copy) NSString *minimum;
@end

@interface QTResult : NSObject
@property (nonatomic, assign) double popularity;
@property (nonatomic, assign) NSInteger voteCount;
@property (nonatomic, assign) BOOL isVideo;
@property (nonatomic, copy)   NSString *posterPath;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL isAdult;
@property (nonatomic, copy)   NSString *backdropPath;
@property (nonatomic, copy)   NSString *originalLanguage;
@property (nonatomic, copy)   NSString *originalTitle;
@property (nonatomic, copy)   NSArray<NSNumber *> *genreIDS;
@property (nonatomic, copy)   NSString *genresString;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, assign) double voteAverage;
@property (nonatomic, copy)   NSString *overview;
@property (nonatomic, copy)   NSString *releaseDate;
@property (nonatomic, copy)   NSData *coverData;
@end

NS_ASSUME_NONNULL_END

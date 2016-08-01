//
//  HAPDFConverter.h
//  TestPdf
//
//  Created by Hipolito Arias on 31/7/16.
//  Copyright © 2016 Hipolito Arias. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HAPDFConverter : NSObject

@property (nonatomic,copy) void (^completionRender)(UIImageView * imageView, NSError *err);
@property (nonatomic,copy) void (^completionBlock)(NSString * saveOnFileName, NSError *err);

/**
 *  Create PDF file to UITableView
 *
 *  @param tableView      It`s UITableView for render content
 *  @param saveOnFileName Name of file Example: test.pdf
 *
 *  @return File on pdf file is saved
 */
+ (void)createTableWithTableView:(UITableView *)tableView
     saveToDocumentsWithFileName:(NSString *)saveOnFileName
                 completionBlock:(void (^)(NSString *documentsDirectory, NSError *err))completionBlock;


/**
 *  Cretate PDF from UIView
 *
 *  @param aView     It`s UIView for render content
 *  @param aFilename Name of file Example: test.pdf
 *
 *  @return File on pdf file is saved
 */
+ (void)renderTableView:(UITableView *)tableView
               fileName:(NSString *)fileName
        completionBlock:(void (^)(NSString *documentsDirectory, NSError *err))completionBlock;

/**
 *  <#Description#>
 *
 *  @param aView           <#aView description#>
 *  @param aFilename       <#aFilename description#>
 *  @param completionBlock <#completionBlock description#>
 */
+ (void)createPDFfromUIView:(UIView*)aView
saveToDocumentsWithFileName:(NSString*)aFilename
            completionBlock:(void (^)(NSString *documentsDirectory, NSError *err))completionBlock;

/**
 *  Show PDF created on UIWebView
 *
 *  @param documentDirectoryFilename File on PDF is saved
 */
+ (void)sampleTestShowingPDFWithDocumentsDirectoryFileName:(NSString *)documentDirectoryFilename;

@end

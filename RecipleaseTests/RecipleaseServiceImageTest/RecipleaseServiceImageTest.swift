//
//  RecipleaseServiceImageTest.swift
//  RecipleaseTests
//
//  Created by Loranne Joncheray on 23/03/2023.
//
@testable import Reciplease
import XCTest

final class RecipleaseServiceImageTest: XCTestCase {
    
    func TestFailedImageDownloadPlaceholderDownload() {
        let mockProvider = RecipleaseImageMockProvider(result: .failure(ErrorCase.errorDecode))
        
        let imageUrl = "https://www.ptitchef.com/recettes/dessert/gateau-au-chocolat-tout-simple-fid-1566045"
        
        let recipleaseService = RecipleaseImageService(sessionImage: mockProvider)
        
        let imageView = UIImageView()
        // imageUrl et non image
        recipleaseService.request(imageUrl: imageUrl, object: imageView)
        
        XCTAssertEqual(imageView.image, UIImage(named: "pizza"))
    }
    
    
    func testIsSuccess() {
        let myImage = UIImage(systemName: "hand.thumbsup")!
        
        let imageUrl = "https://www.ptitchef.com/recettes/dessert/gateau-au-chocolat-tout-simple-fid-1566045"
        
        let mockProvider = RecipleaseImageMockProvider(result: .success(myImage))
        
        let recipleaseService = RecipleaseImageService(sessionImage: mockProvider)
        let imageView = UIImageView()
        
        recipleaseService.request(imageUrl: imageUrl, object: imageView)
        
        XCTAssertEqual(imageView.image, myImage)
    }
}

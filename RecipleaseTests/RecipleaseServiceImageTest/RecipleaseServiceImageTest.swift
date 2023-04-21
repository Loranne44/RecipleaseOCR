//
//  RecipleaseServiceImageTest.swift
//  RecipleaseTests
//
//  Created by Loranne Joncheray on 23/03/2023.
//
@testable import Reciplease
import XCTest

final class RecipleaseServiceImageTest: XCTestCase {
    
    /*
     func testBlablaisSuccess() {
         let myImage = UIImage(named: "pizza")!
         let mockProvider = RecipleaseImageMockProvider(result: .success(myImage))
         let placeholderImage = UIImage()
         let recipleaseService = RecipleaseImageService(sessionImage: mockProvider)
         let imageView = UIImageView()
         
         recipleaseService.sessionImage.setImage(url: URL(string: "fakeURl")!, placeholderImage: placeholderImage, object: imageView)
         XCTAssertEqual(imageView.image, myImage)
     }
     
     func testBlablaIsFailure() {
         let mockProvider = RecipleaseImageMockProvider(result: .failure(ErrorCase.errorDecode))
         
         let placeholderImage = UIImage()
         
         let recipleaseService = RecipleaseImageService(sessionImage: mockProvider)
         
         let imageView = UIImageView()
         
        recipleaseService.sessionImage.setImage(url: URL(string: "fakeURl")!, placeholderImage: placeholderImage, object: imageView)
         
         XCTAssertEqual(imageView.image, placeholderImage)
     }
     */

    func testIsFailure() {
        let mockProvider = RecipleaseImageMockProvider(result: .failure(ErrorCase.errorDecode))
        
        let imageTest = "https://www.ptitchef.com/recettes/dessert/gateau-au-chocolat-tout-simple-fid-1566045"
        
        let recipleaseService = RecipleaseImageService(sessionImage: mockProvider)
        
        let imageView = UIImageView()
        
        recipleaseService.request(image: imageTest, object: imageView)
    
        XCTAssertEqual(imageView.image, UIImage(named: "pizza"))
    }
    
    
    func testIsSuccess() {
        let myImage = UIImage(named: "pizza")!
        
        let imageTest = "https://www.ptitchef.com/recettes/dessert/gateau-au-chocolat-tout-simple-fid-1566045"
        
        let mockProvider = RecipleaseImageMockProvider(result: .success(myImage))

        let recipleaseService = RecipleaseImageService(sessionImage: mockProvider)
        let imageView = UIImageView()
        
        recipleaseService.request(image: imageTest, object: imageView)
    
        XCTAssertEqual(imageView.image, myImage)
    }
}

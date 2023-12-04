//
//  NetworkingTests.swift
//  UnitTestingAssignmentTests
//
//  Created by Levan Loladze on 04.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class NetworkingTests: XCTestCase {
    
    var cartViewModel: CartViewModel!
    var mockedNetwork: NetworkManagerMock!
    
    override func setUpWithError() throws {
        mockedNetwork = NetworkManagerMock()
        cartViewModel = CartViewModel(networkManager: mockedNetwork)
    }
    
    override func tearDownWithError() throws {
        cartViewModel = nil
        mockedNetwork = nil
    }
    
    
    func testFetchProducts() {
        
        cartViewModel.fetchProducts()
        
        XCTAssertEqual(cartViewModel.allproducts?.count, 5)
    }
    
    func testFetchProductsSuccess() {
        let expectation = expectation(description: "Network call successfull")
        
        cartViewModel.fetchProducts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.cartViewModel.allproducts)
            XCTAssertEqual(self.cartViewModel.allproducts?.count, 5)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchProductsFailure() {
        let expectation = expectation(description: "Network call failed")
        mockedNetwork.shouldFail = true
        
        cartViewModel.fetchProducts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNil(self.cartViewModel.allproducts)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}



//
//  CartViewModelTest.swift
//  UnitTestingAssignmentTests
//
//  Created by Levan Loladze on 03.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class CartViewModelTest: XCTestCase {
    
    var cartViewModel: CartViewModel!
    
    override func setUpWithError() throws {
        cartViewModel = CartViewModel()
    }
    
    override func tearDownWithError() throws {
        cartViewModel = nil
    }
    
    
    func testAddItemToCart() {
        let product = Product(id: 10, title: "Test", description: "testcase", price: 100.0, selectedQuantity: 1)
        
        cartViewModel.addProduct(product: product)
        
        XCTAssertEqual(cartViewModel.selectedProducts.count, 1)
        XCTAssertEqual(cartViewModel.selectedProducts.first?.id, 10)
    }
    
    
    func testAddItemToCartWithId() {
        let product = Product(id: 2, title: "testId", description: "idtesting", price: 6.0, selectedQuantity: 2)
        cartViewModel.allproducts = [product]
        
        cartViewModel.addProduct(withID: 2)
        
        XCTAssertEqual(cartViewModel.selectedProducts.count, 1)
        XCTAssertEqual(cartViewModel.selectedProducts.first?.id, 2)
    }
    
    func testAddRandomProduct() {
        let firstRandomProduct = Product(id: 2, title: "test1", description: "idtesting", price: 6.0, selectedQuantity: 2)
        let secondRandomProduct = Product(id: 3, title: "test2", description: "", price: 6.0, selectedQuantity: 2)
        cartViewModel.allproducts = [firstRandomProduct, secondRandomProduct]
        
        cartViewModel.addRandomProduct()
        let result = cartViewModel.selectedProducts.first?.id
        XCTAssert(result == 2 || result == 3)
    }
    
    func testRemoveProduct() {
        let product = Product(id: 2, title: "testId", description: "idtesting", price: 6.0, selectedQuantity: 2)
        cartViewModel.addProduct(product: product)
        
        cartViewModel.removeProduct(withID: 2)
        
        XCTAssertEqual(cartViewModel.selectedProducts.count, 0)
    }
    
    func testClearCart() {
        let product = Product(id: 2, title: "testId", description: "idtesting", price: 6.0, selectedQuantity: 2)
        cartViewModel.addProduct(product: product)
        
        cartViewModel.clearCart()
        
        XCTAssertEqual(cartViewModel.selectedProducts.count, 0)
    }
    
    func testTotalPrice() {
        let product1 = Product(id: 2, title: "test1", description: "idtesting", price: 6.0, selectedQuantity: 2)
        let product2 = Product(id: 3, title: "test2", description: "idtesting", price: 10.0, selectedQuantity: 3)
        cartViewModel.addProduct(product: product1)
        cartViewModel.addProduct(product: product2)
        
        let totalPrice = cartViewModel.totalPrice
        
        XCTAssertEqual(totalPrice, 6.0 * 2 + 3 * 10.0)
    }
    
    func testSelectedItemsQuantity() {
        let product1 = Product(id: 2, title: "test1", description: "idtesting", price: 6.0, selectedQuantity: 2)
        let product2 = Product(id: 3, title: "test2", description: "idtesting", price: 10.0, selectedQuantity: 3)
        cartViewModel.addProduct(product: product1)
        cartViewModel.addProduct(product: product2)
        
        let selectedItemsQuantity = cartViewModel.selectedItemsQuantity
        
        XCTAssertEqual(selectedItemsQuantity, 2 + 3)
    }
    
    func testFetchProducts() {
        let mockedNetwork = NetworkManagerMock()
        let viewModel = CartViewModel(networkManager: mockedNetwork)
        viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.allproducts?.count, 5)
    }
    
    
}

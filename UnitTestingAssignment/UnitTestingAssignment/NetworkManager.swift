//
//  NetworkManager.swift
//  UnitTestingAssignment
//
//  Created by Baramidze on 02.12.23.
//

import Foundation

protocol NetworkManaging {
    func fetchProducts(completion: @escaping (Result<[Product]?, Error>) -> Void)
}

// changed from singleton
final class NetworkManager: NetworkManaging {
    
// static let shared = NetworkManager()
    private let productsUrlString = "https://dummyjson.com/products"
    
    init() {}
    
    // MARK: - Fetch products
    func fetchProducts(completion: @escaping (Result<[Product]?, Error>) -> Void) {
        
        let url = URL(string: productsUrlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError()))
                return
            }
            
            do {
                let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
                completion(.success(productsResponse.products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: MockNetworkManager
final class NetworkManagerMock: NetworkManaging {
    func fetchProducts(completion: @escaping (Result<[Product]?, Error>) -> Void) {
        let products = [
                Product(id: 1, title: "iPhone 9", description: "An apple mobile which is nothing like apple", price: 549),
                Product(id: 2, title: "iPhone X", description: "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...", price: 899),
                Product(id: 3, title: "Samsung Universe 9", description: "Samsung's new variant which goes beyond Galaxy to the Universe", price: 1249),
                Product(id: 4, title: "OPPOF19", description: "OPPO F19 is officially announced on April 2021.", price: 280),
                Product(id: 5, title: "Huawei P30", description: "Huawei’s re-badged P30 Pro New Edition was officially unveiled yesterday in Germany and now the device has made its way to the UK.", price: 499)
        ]
        completion(.success(products))
    }
    
    
}

//
//  AllStore.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 1/9/2562 BE.
//  Copyright (c) 2562 SCB. All rights reserved.
//

import Foundation

/*

 The AllStore class implements the AllStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class MobilesStore: MobilesProtocol {
    
    func fetchMobiles(_ completion: @escaping (Result<[Mobile], Error>) -> Void) {
        ContentManager.shared.loadContent { (response) in
            switch response {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

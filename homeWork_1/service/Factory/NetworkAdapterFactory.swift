//
//  NetworkAdapterFactory.swift
//  homeWork_1
//
//  Created by Mac on 19.10.2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol NetworkAdapterFactoryProtocol {
    func makeAdapter() -> NetworkAdapterInterface
}

class NetworkAdapterFactory: NetworkAdapterFactoryProtocol {
    
    // В режиме отладки логгирование запросов не нужно
    func makeAdapter() -> NetworkAdapterInterface {
        let adapter: NetworkAdapterInterface = NetworkAdapter()
        #if DEBUG
        return adapter
        #else
        let loggerAdapter = NetworkLoggerAdapter(adapter: adapter)
        return loggerAdapter
        #endif
    }
}

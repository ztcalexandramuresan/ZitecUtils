//
//  ConsoleLogging.swift
//  
//
//  Created by alexandra.muresan on 21.06.2023.
//

import Foundation

protocol ConsoleLogging {
    func log(_ request: URLRequest)
    func log(_ response: URLResponse, _ data: Data)
    func log(_ error: Error)
}

private extension Array where Element == String {
    mutating func append(_ output: ConsoleOutput) {
        append(output.value)
    }
}

extension ConsoleLogging {

    func log(_ request: URLRequest) {
        var array: [String] = []
                
        if let method = request.httpMethod,
           let url = request.url?.absoluteString {
            array.append(.request(method: method, url: url))
        }
        if let dict = request.allHTTPHeaderFields, !dict.isEmpty {
            array.append(.headers(dict))
        }
        
        if let data = request.httpBody,
            let string = String(json: data), !string.isEmpty {
             array.append(.body(string))
        }
        
        if let inputStream = request.httpBodyStream,
           let data = Data(stream: inputStream),
           let string = String(json: data), !string.isEmpty {
            array.append(.body(string))
        }
        Logger.shared.logInfo(array.joined(separator: "\n"))
    }
    
    func log(_ response: URLResponse, _ data: Data) {
        guard let urlResponse = response as? HTTPURLResponse,
              let url = urlResponse.url?.absoluteString.replacingOccurrences(of: "https://", with: "")
        else { return }
        
        var array: [String] = []
        
        array.append(.response(code: urlResponse.statusCode, url: url))
        if let string = String(json: data), !string.isEmpty {
            array.append(.body(string))
        }
        Logger.shared.logInfo(array.joined(separator: "\n"))
    }
        
    func log(_ error: Error) {
        guard let error = error as? URLError else { return }
        
        let output: ConsoleOutput = .failure(error)
        Logger.shared.logError(output.value)
    }
}

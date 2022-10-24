//
//  NetworkService.swift
//  AvitoTest
//
//  Created by Мария Ганеева on 23.10.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getEmployee(completion: @escaping (Result<Welcome?, Error>) -> Void )
}

class NetworkService: NetworkServiceProtocol {
    // MARK: - Properties
    private let allowedDiskSize = 100 * 1024 * 1024
    private lazy var cache: URLCache = {
        let urlCache = URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize)
        return urlCache
    }()

    // MARK: - Methods
    func getEmployee(completion: @escaping (Result<Welcome?, Error>) -> Void) {
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)

        if let cachedData = self.cache.cachedResponse(for: request) {
            do {
                let obj = try JSONDecoder().decode(Welcome.self, from: cachedData.data)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                guard let error = error else {
                    return
                }
                guard let response = response else {
                    completion(.failure(error))
                    return
                }
                do {
                    var object = try JSONDecoder().decode(Welcome.self, from: data!)
                    let sortObj = object.company.employees.sorted(by: {$0.name < $1.name})
                    object.company.employees = sortObj

                    let dataCache = try JSONEncoder().encode(object)
                    let cachedResponse = self.willCacheResponse(cachedResponse: CachedURLResponse(
                        response: response,
                        data: dataCache,
                        userInfo: nil,
                        storagePolicy: .allowed))

                    URLCache.shared.storeCachedResponse(cachedResponse ?? CachedURLResponse(), for: request)
                    let cachedData = cachedResponse
                    self.cache.storeCachedResponse(cachedData!, for: request)

                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }).resume()
        }
    }
}

// MARK: - Extension NetworkService
extension NetworkService {
    private func willCacheResponse(cachedResponse: CachedURLResponse) -> CachedURLResponse?
    {
        let response = cachedResponse.response
        let HTTPresponse: HTTPURLResponse = response as! HTTPURLResponse
        let headers: NSDictionary = HTTPresponse.allHeaderFields as NSDictionary
        let modifiedHeaders: NSMutableDictionary = headers.mutableCopy() as! NSMutableDictionary

        modifiedHeaders["Cache-Control"] = "max-age=3600"

        let modifiedResponse: HTTPURLResponse = HTTPURLResponse(
            url: HTTPresponse.url!,
            statusCode: HTTPresponse.statusCode,
            httpVersion: "HTTP/1.1",
            headerFields: modifiedHeaders as? [String : String])!

        let modifiedCachedResponse = CachedURLResponse(
            response: modifiedResponse,
            data: cachedResponse.data,
            userInfo: cachedResponse.userInfo,
            storagePolicy: cachedResponse.storagePolicy)

        return modifiedCachedResponse
    }
}

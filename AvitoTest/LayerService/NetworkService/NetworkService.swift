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
    func getEmployee(completion: @escaping (Result<Welcome?, Error>) -> Void) {
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                var object = try JSONDecoder().decode(Welcome.self, from: data!)
                print(object)
                let sortObj = object.company.employees.sorted(by: {$0.name < $1.name})
                object.company.employees = sortObj
                print(object)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
}
//    private let session = URLSession(configuration: .default)
//    private var workerNotes: Welcome?
//    func getJSON() {
//        guard let url = URL(
//            string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
//        ) else { return }
//        session.dataTask(with: url) { [self] (data, _, error) in
//            guard let data = data else {
//                return
//            }
//            do {
//                self.workerNotes = try JSONDecoder().decode(Welcome.self, from: data)
//            } catch {
//                print(error)
//            }
//        }.resume()
//    }

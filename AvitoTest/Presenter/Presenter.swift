//
//  Presenter.swift
//  AvitoTest
//
//  Created by Мария Ганеева on 23.10.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getObject()
    var personData: Welcome? { get }
}

class MainPresenter: MainViewPresenterProtocol {
    // MARK: - Properties
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    let router: RouterProtocol?
    var personData: Welcome?

    // MARK: - Init
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getObject()
    }

    // MARK: - Methods
    func getObject() {
        networkService.getEmployee(completion: { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let personData):
                    self.personData =  personData
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                    print(error.localizedDescription)
                }
            }
        })
    }
}


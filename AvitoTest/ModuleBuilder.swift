//
//  ModuleBuilder.swift
//  AvitoTest
//
//  Created by Мария Ганеева on 23.10.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: AssemblyBuilderProtocol {
    func createMainModule (router: RouterProtocol) -> UIViewController {
        let view = ViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}


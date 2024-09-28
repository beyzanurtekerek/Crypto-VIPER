//
//  Router.swift
//  CryptoVIPER
//
//  Created by Beyza Nur Tekerek on 28.09.2024.
//

import Foundation
import UIKit

// class, protocol
// entry point
// aralarındaki iletisim ve orkestra görevini üstlenir

typealias EntryPoint = AnyView & UIViewController // entrypoint gordugun heryer bu demek

protocol AnyRouter {
    
    var entry : EntryPoint? { get }
    static func startExecution() -> AnyRouter
    
}

class CryptoRouter: AnyRouter {
    
    var entry : EntryPoint?
    
    static func startExecution() -> any AnyRouter {
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        // hepsini birbirine baglıyoruz
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
       
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
        
    }
    
}


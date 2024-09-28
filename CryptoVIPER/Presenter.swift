//
//  Presenter.swift
//  CryptoVIPER
//
//  Created by Beyza Nur Tekerek on 28.09.2024.
//

import Foundation

// talks to -> interactor, router, view
// class, protocol

enum NetworkError: Error {
    
    case NetworkFiled
    case ParsingFailed
    
}

protocol AnyPresenter {
    
    var router : AnyRouter? { get set }
    var interactor : AnyInteractor? { get set }
    var view : AnyView? { get set }
    
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
    
}

class CryptoPresenter: AnyPresenter {
    
    var router: (any AnyRouter)?
    var interactor: (any AnyInteractor)? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
        
    
    var view: (any AnyView)?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], any Error>) {
        
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Try again later.")
        }
        
    }
    
}

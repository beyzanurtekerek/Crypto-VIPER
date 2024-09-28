//
//  Interactor.swift
//  CryptoVIPER
//
//  Created by Beyza Nur Tekerek on 28.09.2024.
//

import Foundation

// talks to -> presenter
// class, protocol
// tek yapacagı sey cryptoları download etmek ve presentera haber vermek

protocol AnyInteractor {
    
    var presenter: AnyPresenter? { get set }
    
    func downloadCryptos()
    
}

class CryptoInteractor: AnyInteractor {
    
    var presenter: (any AnyPresenter)?
    
    func downloadCryptos() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/refs/heads/master/crypto.json") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFiled))
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            } catch {
                self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
            
        }
        task.resume()
        
    }

}

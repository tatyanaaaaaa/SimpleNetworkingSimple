//
//  MainScreenAssembly.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// Сборщик `Главного экрана`
final class MainScreenAssembly {
    
    /// Собирает экран
    /// - Returns: собранный модуль
    func createModule() -> MainScreenModule {
        
        let interactor = MainScreenInteractor()
        let view = MainScreenView()
        let factory = MainScreenFactory()
        
        let presenter = MainScreenViewController(interactor: interactor,
                                                 moduleView: view,
                                                 factory: factory)
        
        
        // Паттерн "Делегат", PRESENTER будет принимать события через OUTPUT от `view`, `interactor` и `factory`
        view.output = presenter
        interactor.output = presenter
        factory.output = presenter
        return presenter
    }
}

//
//  MainScreenViewController.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// события которые отправляем из `ТЕКУЩЕГО МОДУЛЯ` в  `ДРУГОЙ МОДУЛЬ`
protocol MainScreenModuleOutput: AnyObject {
    
    /// Пользователь нажал `Изменить цвет экрана`
    /// - Parameter color:  для view
    func userPressedChange(color: UIColor?)
}

/// события которые отправляем из `ДРУГОГО МОДУЛЯ` в  `ТЕКУЩИЙ МОДУЛЬ`
protocol MainScreenModuleInput {
    
    /// Обработчик событий от `Главного экрана`
    var moduleOutput: MainScreenModuleOutput? { get set }
}

/// Готовый модуль `Главного экрана`
typealias MainScreenModule = UIViewController & MainScreenModuleInput

/// Главный экран
final class MainScreenViewController: UIViewController, MainScreenModuleInput {
    
    // MARK: - Internal property
    
    weak var moduleOutput: MainScreenModuleOutput?
    
    // MARK: - Private property
    
    private let interactor: MainScreenInteractorInput
    private let moduleView: UIView & MainScreenViewInput
    private let factory: MainScreenFactoryInput
    
    /// Инициализатор
    /// - Parameters:
    ///   - interactor: интерактор
    ///   - moduleView: вью
    ///   - factory: фабрика
    init(interactor: MainScreenInteractorInput,
         moduleView: UIView & MainScreenViewInput,
         factory: MainScreenFactoryInput) {
        self.interactor = interactor
        self.moduleView = moduleView
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = moduleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.getContent()
        title = Appearance().title
    }
}

// MARK: - MainScreenInteractorOutput

extension MainScreenViewController: MainScreenInteractorOutput {
    func didReceive(text: String) {
        factory.createTitle(text: text)
    }
}

// MARK: - MainScreenViewOutput

extension MainScreenViewController: MainScreenViewOutput {
    func presentNewScreenButtonAction() {
        moduleView.changeBackgroundColor()
        
        /// Событие пробрасываем `Из зекущего модуля` в `Другой модуль`
        moduleOutput?.userPressedChange(color: view.backgroundColor)
    }
}

// MARK: - MainScreenFactoryOutput

extension MainScreenViewController: MainScreenFactoryOutput {
    func didReciveFull(text: String) {
        moduleView.setTitle(text: text)
    }
}

// MARK: - Appearance

private extension MainScreenViewController {
    struct Appearance {
        let title = "VIPER Архитектура"
    }
}

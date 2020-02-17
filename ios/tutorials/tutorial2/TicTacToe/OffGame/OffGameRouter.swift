//
//  OffGameRouter.swift
//  TicTacToe
//
//  Created by Elon on 2020/02/19.
//  Copyright © 2020 Uber. All rights reserved.
//

import RIBs

protocol OffGameInteractable: Interactable, TicTacToeListener {
    var router: OffGameRouting? { get set }
    var listener: OffGameListener? { get set }
}

protocol OffGameViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class OffGameRouter: ViewableRouter<OffGameInteractable, OffGameViewControllable>, OffGameRouting {
  
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: OffGameInteractable,
                  viewController: OffGameViewControllable,
                  ticTacToeBuilder: TicTacToeBuildable) {
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func rotueToTicTacToe() {
        attachTicTacToe()
    }
    
    // - MARK: Private
    
    private let ticTacToeBuilder: TicTacToeBuildable
    
    private var currentChild: ViewableRouting?
    
    private func attachTicTacToe() {
        let ticTacToe = ticTacToeBuilder.build(withListener: interactor)
        self.currentChild = ticTacToe
        attachChild(ticTacToe)
        viewController.present(viewController: ticTacToe.viewControllable)
    }
}

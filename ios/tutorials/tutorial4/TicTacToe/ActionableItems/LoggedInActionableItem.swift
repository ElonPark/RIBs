//
//  LoggedInActionableItem.swift
//  TicTacToe
//
//  Created by Elon on 2020/03/02.
//  Copyright © 2020 Uber. All rights reserved.
//

import RxSwift

public protocol LoggedInActionableItem: class {
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())>
}

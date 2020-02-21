//
//  ScoreStream.swift
//  TicTacToe
//
//  Created by Elon on 2020/02/22.
//  Copyright © 2020 Uber. All rights reserved.
//

import RxSwift
import RxRelay

struct Score: Equatable {
    let player1Score: Int
    let player2Score: Int
}

protocol ScoreStream: class {
    var score: Observable<Score> { get }
}

protocol MutableScoreStream: ScoreStream {
    func updateScore(withWinner winner: PlayerType)
}

class ScoreStreamImpl: MutableScoreStream {
    
    var score: Observable<Score> {
        return variable
            .asObservable()
            .distinctUntilChanged()
    }
    
    func updateScore(withWinner winner: PlayerType) {
        let newScore: Score = {
            let currentScore = variable.value
            switch winner {
            case .player1:
                return Score(player1Score: currentScore.player1Score + 1,
                             player2Score: currentScore.player2Score)
            case .player2:
                return Score(player1Score: currentScore.player1Score,
                             player2Score: currentScore.player2Score + 1)
            }
        }()
        variable.accept(newScore)
    }
    
    // MARK: - Private
    
    private let variable = BehaviorRelay<Score>(value: .init(player1Score: 0, player2Score: 0))
}

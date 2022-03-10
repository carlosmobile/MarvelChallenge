//
//  AutoSearchTimer.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 10/3/22.
//

import Foundation

class AutoSearchTimer {

    let shortInterval: TimeInterval
    let longInterval: TimeInterval
    let callback: () -> Void

    var shortTimer: Timer?
    var longTimer: Timer?

    enum Const {
        static let longAutosearchDelayWhileTyping: TimeInterval = 2.0
        static let shortAutosearchDelayAfterPauseTyping: TimeInterval = 0.75
    }

    init(short: TimeInterval = Const.shortAutosearchDelayAfterPauseTyping,
         long: TimeInterval = Const.longAutosearchDelayWhileTyping,
         callback: @escaping () -> Void) {
        shortInterval = short
        longInterval = long
        self.callback = callback
    }

    func activate() {
        shortTimer?.invalidate()
        shortTimer = Timer.scheduledTimer(withTimeInterval: shortInterval, repeats: false)
            { [weak self] _ in self?.fire() }
        if longTimer == nil {
            longTimer = Timer.scheduledTimer(withTimeInterval: longInterval, repeats: false)
            { [weak self] _ in self?.fire() }
        }
    }

    func cancel() {
        shortTimer?.invalidate()
        longTimer?.invalidate()
        shortTimer = nil
        longTimer = nil
    }

    private func fire() {
        cancel()
        callback()
    }
}


//
//  ExSlideMenuContronller.swift
//  HVN MACs
//
//

import UIKit
class ExSlideMenuContronller: SlideMenuController {
    override func track(_ trackAction: TrackAction) {
        switch trackAction {
        case .leftTapOpen:
            print("TrackAction: left tap open.")
        case .leftTapClose:
//            AppDelegate.sharedInstance.leftMenuHere?.gotoTop()
            print("TrackAction: left tap close.")
        case .leftFlickOpen:
            print("TrackAction: left flick open.")
        case .leftFlickClose:
//            AppDelegate.sharedInstance.leftMenuHere?.gotoTop()
            print("TrackAction: left flick close.")
        case .rightTapOpen:
            print("TrackAction: right tap open.")
        case .rightTapClose:
            print("TrackAction: right tap close.")
        case .rightFlickOpen:
            print("TrackAction: right flick open.")
        case .rightFlickClose:
            print("TrackAction: right flick close.")
        }
    }

}

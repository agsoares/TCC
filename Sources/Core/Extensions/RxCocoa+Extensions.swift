//
//  RxCocoa+Extensions.swift
//  TCC
//
//  Created by Adriano Guimarães Soares on 31/03/19.
//  Copyright © 2019 Adriano Soares. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: UIButton {

    /// Reactive wrapper for `TouchUpInside` control event with default throttle.
    public var tapWithThrottle: ControlEvent<Void> {
        return ControlEvent<Void>(events: self.tap.throttle(0.5, scheduler: MainScheduler.asyncInstance))
    }
}

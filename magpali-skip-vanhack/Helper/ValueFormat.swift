//
//  ValueFormat.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit

extension Double {
    func moneyFormat() -> String {
        return String(format: "%.2f", self)
    }
}

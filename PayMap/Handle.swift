//
//  Handle.swift
//  PayMap
//
//  Created by Tyler Phillips on 12/3/19.
//  Copyright © 2019 Tyler P Admin. All rights reserved.
//

import Foundation
import SwiftUI

struct Handle : View {
    private let handleThickness = CGFloat(5.0)
    var body: some View {
        RoundedRectangle(cornerRadius: handleThickness / 2.0)
            .frame(width: 40, height: handleThickness)
            .foregroundColor(Color.secondary)
            .padding(5)
    }
}

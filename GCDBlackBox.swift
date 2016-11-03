//
//  GCDBlackBox.swift
//  On The Map
//
//  Created by Ayush Garg on 26/10/16.
//  Copyright © 2016 Headmaster Technologies. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}

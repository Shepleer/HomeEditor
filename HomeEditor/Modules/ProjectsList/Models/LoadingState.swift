//
//  LoadingState.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import Foundation

enum LoadingState {
    case loading
    case error(_ errorText: String)
    case done
}

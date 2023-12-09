//
//  searchByAtomicNumber.swift
//  chemAR
//
//  Created by Neeraj Shetkar on 09/12/23.
//

import Foundation

func searchElement(byNumber number: Int, in elements: [String: ElementInfo]) -> ElementInfo? {
    return elements.values.first(where: { $0.number == number })
}

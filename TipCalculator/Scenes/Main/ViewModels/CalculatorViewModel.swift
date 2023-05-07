//
//  CalculatorViewModel.swift
//  TipCalculator
//
//  Created by Danijel Kecman on 5/7/23.
//

import Foundation
import Combine

class CalculatorViewModel {
  struct Input {
    let billPublisher: AnyPublisher<Double, Never>
    let tipPublisher: AnyPublisher<Tip, Never>
    let splitPublisher: AnyPublisher<Int, Never>
  }

  struct Output {
    let updateViewPublisher: AnyPublisher<CalculatorResult, Never>
  }

  func transform(input: Input) -> Output {
    let calculatorResult = CalculatorResult(amountPerson: 500, totalBill: 1000, totalTill: 50.0)
    return Output(updateViewPublisher: Just(calculatorResult).eraseToAnyPublisher())
  }
}

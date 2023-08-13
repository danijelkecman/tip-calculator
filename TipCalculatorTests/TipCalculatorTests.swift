//
//  TipCalculatorTests.swift
//  TipCalculatorTests
//
//  Created by Danijel Kecman on 2/23/23.
//

import XCTest
import Combine
@testable import TipCalculator

final class TipCalculatorTests: XCTestCase {
  private var sut: CalculatorViewModel!
  private var logoViewTapSubject: PassthroughSubject<Void, Never>!
  private var audioPlayerService: MockAudioPlayerService!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    audioPlayerService = .init()
    sut = .init(audioPlayerService: audioPlayerService)
    logoViewTapSubject = .init()
    cancellables = .init()
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    logoViewTapSubject = nil
    cancellables = nil
    audioPlayerService = nil
  }
  
  func testResultWithoutTipForOnePerson() {
    // given
    let bill: Double = 100.0
    let tip: Tip = .none
    let split: Int = 1
    let input = buildInput(bill: bill, tip: tip, split: split)
    // when
    let output = sut.transform(input: input)
    // then
    output.updateViewPublisher.sink { result in
      XCTAssertEqual(result.amountPerson, 100)
      XCTAssertEqual(result.totalBill, 100)
      XCTAssertEqual(result.totalTip, 0)
    }.store(in: &cancellables)
  }
  
  func testResultWithoutTipForTwoPersons() {
    // given
    let bill: Double = 200.0
    let tip: Tip = .none
    let split: Int = 2
    let input = buildInput(bill: bill, tip: tip, split: split)
    // when
    let output = sut.transform(input: input)
    // then
    output.updateViewPublisher.sink { result in
      XCTAssertEqual(result.amountPerson, 100)
      XCTAssertEqual(result.totalBill, 200)
      XCTAssertEqual(result.totalTip, 0)
    }.store(in: &cancellables)
  }
  
  func testResultWithTenPercentTipForTwoPersons() {
    // given
    let bill: Double = 100.0
    let tip: Tip = .tenPercent
    let split: Int = 2
    let input = buildInput(bill: bill, tip: tip, split: split)
    // when
    let output = sut.transform(input: input)
    // then
    output.updateViewPublisher.sink { result in
      XCTAssertEqual(result.amountPerson, 55)
      XCTAssertEqual(result.totalBill, 110)
      XCTAssertEqual(result.totalTip, 10)
    }.store(in: &cancellables)
  }
  
  func testResultWithCustomTipForFourPersons() {
    // given
    let bill: Double = 400.0
    let tip: Tip = .custom(value: 25)
    let split: Int = 4
    let input = buildInput(bill: bill, tip: tip, split: split)
    // when
    let output = sut.transform(input: input)
    // then
    output.updateViewPublisher.sink { result in
      XCTAssertEqual(result.amountPerson, 106.25)
      XCTAssertEqual(result.totalBill, 425)
      XCTAssertEqual(result.totalTip, 25)
    }.store(in: &cancellables)
  }
  
  func testSoundPlayedAndCalculatorResetOnLogoViewDoubleTap() {
    // given
    let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
    let output = sut.transform(input: input)
    let expectation1 = XCTestExpectation(description: "reset calculator called")
    let expectation2 = audioPlayerService.expectation
    // then
    output.resetCalculatorPublisher.sink { _ in
      expectation1.fulfill()
    }.store(in: &cancellables)
    // when
    logoViewTapSubject.send()
    wait(for: [expectation1, expectation2], timeout: 1.0)
  }
  
  private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorViewModel.Input {
    return .init(
      billPublisher: Just(bill).eraseToAnyPublisher(),
      tipPublisher: Just(tip).eraseToAnyPublisher(),
      splitPublisher: Just(split).eraseToAnyPublisher(),
      logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
  }
}

class MockAudioPlayerService: AudioPlayerServiceProtocol {
  var expectation = XCTestExpectation(description: "playSound is called")
  func playSound() {
    expectation.fulfill()
  }
}

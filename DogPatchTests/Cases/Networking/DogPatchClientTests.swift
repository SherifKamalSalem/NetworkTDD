/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

@testable import DogPatch
import XCTest

class DogPatchClientTests: XCTestCase {

  var baseURL: URL!
  var mockSession: MockURLSession!
  var sut: DogPatchClient!

  var getDogsURL: URL {
    return URL(string: "dogs", relativeTo: baseURL)!
  }

  override func setUp() {
    super.setUp()
    baseURL = URL(string: "https://example.com/api/v1/")!
    mockSession = MockURLSession()
    sut = DogPatchClient(baseURL: baseURL,
                         session: mockSession)
  }

  override func tearDown() {
    baseURL = nil
    mockSession = nil
    sut = nil
    super.tearDown()
  }

  func test_init_sets_baseURL() {
    XCTAssertEqual(sut.baseURL, baseURL)
  }

  func test_init_sets_session() {
    XCTAssertEqual(sut.session, mockSession)
  }
  
  func test_getDogs_callsExpectedURL() {
    let mockTask = sut.getDogs { _, _ in } as! MockURLSessionDataTask
    XCTAssertEqual(mockTask.url, getDogsURL)
  }
  
  func test_getDogs_callsResumeOnTask() {
    let mockTask = sut.getDogs { _, _ in } as! MockURLSessionDataTask
    XCTAssertTrue(mockTask.calledResume)
  }
  
  func test_getDogs_givenResponseStatusCode500_callsCompletion() {
    let response = HTTPURLResponse(url: getDogsURL, statusCode: 500, httpVersion: nil, headerFields: nil)
    var calledCompletion = false
    var receivedDogs: [Dog]? = nil
    var receivedError: Error? = nil
    
    let mockTask = sut.getDogs { dogs, error in
      calledCompletion = true
      receivedDogs = dogs
      receivedError = error
    } as! MockURLSessionDataTask
    
    mockTask.completionHandler(nil, response, nil)
    XCTAssertTrue(calledCompletion)
    XCTAssertNil(receivedDogs)
    XCTAssertNil(receivedError)
  }
  
  func test_getDogs_givenError_callsCompletionWithError() throws {
    let response = HTTPURLResponse(url: getDogsURL, statusCode: 200, httpVersion: nil, headerFields: nil)
    let expectedError = NSError(domain: "com.DogPatchTests", code: 42)
    var calledCompletion = false
    var receivedDogs: [Dog]? = nil
    var receivedError: Error? = nil
    
    let mockTask = sut.getDogs { dogs, error in
      calledCompletion = true
      receivedDogs = dogs
      receivedError = error as NSError?
    } as! MockURLSessionDataTask
    mockTask.completionHandler(nil, response, expectedError) 
    XCTAssertTrue(calledCompletion)
    XCTAssertNil(receivedDogs)
    
    let actualError = try XCTUnwrap(receivedError as NSError?)
    XCTAssertEqual(actualError, expectedError)
  }
}

class MockURLSession: URLSession {

  var queue: DispatchQueue? = nil

  override func dataTask(
    with url: URL,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
      -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler,
                                      url: url)
  }
}

class MockURLSessionDataTask: URLSessionDataTask {

  var completionHandler: (Data?, URLResponse?, Error?) -> Void
  var url: URL

  init(completionHandler:
    @escaping (Data?, URLResponse?, Error?) -> Void,
       url: URL) {
    self.completionHandler = completionHandler
    self.url = url
    super.init()
  }

  var calledResume = false
  override func resume() {
    calledResume = true
  }
}

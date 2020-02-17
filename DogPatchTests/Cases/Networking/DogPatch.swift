
import Foundation

class DogPatchClient {
  let baseURL: URL
  let session: URLSession
  
  init(baseURL: URL, session: URLSession) {
    self.baseURL = baseURL
    self.session = session
  }
  
  func getDogs(completion: @escaping ([Dog]?, Error?) -> Void) -> URLSessionDataTask {
    let url = URL(string: "dogs", relativeTo: baseURL)!
    let task = session.dataTask(with: url) { _, response, error in
      guard let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil else {
        completion(nil, error)
        return
      }
    }
    task.resume()
    return task
  }
}

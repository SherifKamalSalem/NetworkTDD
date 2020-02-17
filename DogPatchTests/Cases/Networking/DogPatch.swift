
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
    return session.dataTask(with: url) { _, _, _ in }
  }
}

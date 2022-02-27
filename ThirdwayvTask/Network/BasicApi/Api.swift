//
//  Api.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import Foundation
import Alamofire

class APIServices <T : TargetType> {
    
    func fetchData<D: Decodable>(target: T,responseClass: D.Type ,completion:@escaping (Result<D?, Error>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let parameters = buildParameters(task: target.task)
        let url = target.base + target.path
        
        
        AF.request(url, method: method, encoding: parameters.1)
            .validate(statusCode: 200..<300)
            .responseJSON{ (response) in
                switch response.result {
                case .success(_):
                    guard let data = response.data else { return }
                    print(data)
                    do {
                        let responseData = try JSONDecoder().decode(D.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(responseData))
                        }
                    } catch {
                        print("Cannot decode data from model \(D.self)")
                    }
                    
                case.failure(let error):
                    
                    let statusCode = response.response?.statusCode ?? 0
                    let errorResponse = try? JSONDecoder().decode(ErrorDataModel?.self, from: response.data!)
                    DispatchQueue.main.async {
                        completion(.failure(errorResponse as! Error))
                        if statusCode == 404{
                            do {
                                Alert.showAlert(title: "Failed", message: errorResponse?.message ?? "")
                            }
                            catch{
                                print("Cannot decode data from model \(D.self)")
                            }
                        }else if statusCode == 406{
                            Alert.showAlert(title: "Failed", message: "Your account is deleted, if you want to restore it click here.")
                        }else if statusCode == 401{
                            Alert.showAlert(title: "Failed", message: "Wrong credentials!")
                        }else if statusCode == 403{
                            Alert.showAlert(title: "Failed", message: "Your account is temporarily blocked by the system, you may refer to support.")
                        }else if statusCode == 400{
                            Alert.showAlert(title: "Failed", message: "Your account is unverified!")
                        }else if statusCode == 412{
                            Alert.showAlert(title: "Failed", message: "Something went wrong, check your data and try again")
                        }else{
                            
                            Alert.showAlert(title: "Failed", message: errorResponse?.message ?? "")
                        }
                    }
                }
            }
    }
    
    func buildParameters(task: Task) ->([String: Any], ParameterEncoding) {
        switch task {
        case.requestPlain:
            return ([:], URLEncoding.default)
        case.requestParameters(parameters: let parameters, encoding: let encoding):
            return(parameters, encoding)
        case.getWithParameters:
            return ([:], URLEncoding.default)
        }
        
    }
}
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

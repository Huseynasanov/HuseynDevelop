//
//  SearchsVM.swift
//  Final
//
//  Created by Huseyn Hasanov on 28.03.22.
//

import Foundation
class SearchVM{
    var successOnSearch: ((NewsData) -> Void)?
    var successOnToday: ((NewsData) -> Void)?
    var successOnInfo: ((NewsData) -> Void)?
    var erro : ((Bool) -> Void)?
    var safeDat  : (() -> Void)?
    var response : (() -> Void)?
    let baseUrl = "https://api.newscatcherapi.com/v2/search?q="
    func getNews(text: String,lang: String){
        let url = "\(baseUrl)\(text)&lang=\(lang)"
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.allHTTPHeaderFields = ["x-api-key":"H6VSiONqsI1Lfv9Qd6C3bSfls4D55jcS1r-nvX1TsqI"]
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, res, err in
            if err != nil{
                print(err ?? 0)
                return
            }
            if let safeDate = data{
                let decoder = JSONDecoder()
                do{
                    let data = try decoder.decode(NewsData.self, from: safeDate)

                    self.successOnSearch?(data)
                }catch{
                    return
                }
            }
        })
        session.resume()
    }
    func getTodayNews(lang: String){
            let url = "\(baseUrl)Today&lang=\(lang)"
        print(url)
        var urlRequest = URLRequest(url: URL(string: url)!)
            urlRequest.allHTTPHeaderFields = ["x-api-key":"H6VSiONqsI1Lfv9Qd6C3bSfls4D55jcS1r-nvX1TsqI"]
            urlRequest.httpMethod = "GET"
            let session = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, res, err in
                if err != nil{
                    print(err ?? 0)
                    return
                }
                if let safeDate = data{
                    let decoder = JSONDecoder()
                    do{
                        let data = try decoder.decode(NewsData.self, from: safeDate)
                        self.successOnToday?(data)
                    }catch{
                        return
                    }
                }
            })
        session.resume()
    }
    func getInfoNews(text: String, lang: String){
        let url = "\(baseUrl)\(text)&lang=\(lang)"
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.allHTTPHeaderFields = ["x-api-key":"H6VSiONqsI1Lfv9Qd6C3bSfls4D55jcS1r-nvX1TsqI"]
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, res, err in
            if err != nil{
                print(err ?? 0)
                return
            }
            if let safeDate = data{
                let decoder = JSONDecoder()
                do{
                    let data = try decoder.decode(NewsData.self, from: safeDate)

                    self.successOnInfo?(data)
                }catch{
                    return
                }
            }
        })
        session.resume()
    }
}

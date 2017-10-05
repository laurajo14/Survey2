//
//  EmojiController.swift
//  Survey2
//
//  Created by Laura O'Brien on 10/5/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import Foundation


class SurveyController {
    
    static let shared = SurveyController()
    
    //Source of Truth
    var surveys: [Survey] = []
    
    private let baseURL = URL(string: "https://favoriteemoji-96d0a.firebaseio.com/")
    
    func putSurvey(with name: String, emoji: String, completion: @escaping (_ success: Bool)-> Void) {
        
        //Create an instance of survey
        let survey = Survey(name: name, emoji: emoji)
        
        guard let url = baseURL else { fatalError("BAD URL") }
        
        //Build URL
        let requestURL = url.appendingPathComponent(survey.identifier.uuidString).appendingPathExtension("json")
        
        //Create Request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.httpBody = survey.jsonData
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in

            var success = false
            
            defer { completion(success) }
            
            if let error = error { print("\(error.localizedDescription) \(#function)") }

            guard let data = data else { return } /*note this is just for the developer*/
            
            let responseDataString = String(data: data, encoding: .utf8)
        
            if let error = error {
                print("Error \(error.localizedDescription) \(#function)")
            } else {
                print("Successfully saved data to endpoint \(responseDataString)")
            }
            
            //add survey to source of truth
            self.surveys.append(survey)
            
            success = true
            
        }.resume()
    }
    
    
    func fetchEmoji(completion: @escaping () -> Void){
        
        guard let url = baseURL?.appendingPathExtension("json") else {
            print("Bad base URL")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
        
            guard let data = data else { print("No data returned from dataTask")
                completion()
                return }
            
            //JSON Serialization
            guard let surveyDictionaries = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: String]]) else {
                print("Fetching JSON Object")
                completion()
                return
            }
            
            guard let surveys = surveyDictionaries?.flatMap({ Survey(dictionary: $0.value, identifier: $0.key) }) else { return }
            
            self.surveys = surveys
            completion()

        }.resume()
    }
}

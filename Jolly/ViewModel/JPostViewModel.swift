//
//  JPostViewModel.swift
//  Jolly
//
//  Created by Apple on 26/04/24.
//

import Foundation


public protocol JPostViewModelDelegate {
    func reloadTable()

}

class JPostViewModel{
    
    //MARK: - Properties
    
    var JPostModelDelegate : JPostViewModelDelegate?
    var arrJPost = [JPostModel]()
    var page : Int = 1
    var limit : Int = 10
    
    //MARK: - Initialization
    
    init(_ jPostViewModelDelegate : JPostViewModelDelegate){
        
        self.JPostModelDelegate = jPostViewModelDelegate
        self.getPostDataAPI()

    }
    
    //MARK: - Custom

    func getPostDataAPI(){
        
        if let post_url = URL(string: BaseURL + "_page=\(page)&_limit=\(limit)"){
            
            URLSession.shared.dataTask(with: post_url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([JPostModel].self, from: data)
                        self.arrJPost.append(contentsOf: result)
                        DispatchQueue.main.async {
                            self.JPostModelDelegate?.reloadTable()
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching media coverages: \(error)")
                }
            }.resume()
        }
    }
    
}


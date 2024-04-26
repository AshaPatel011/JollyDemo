//
//  PostDetailsVC.swift
//  Jolly
//
//  Created by Apple on 26/04/24.
//

import UIKit

class PostDetailsVC: UIViewController {
    
    //MARK: - Outlet

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblUserID: UILabel!
    @IBOutlet weak var lblTilte: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    //MARK: - Properties

    var postData : JPostModel?
    var onCloseClick: (() -> Void)?

    //MARK: - Viewcontroller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup post data
        setData()
        
    }
    
    //MARK: - Custom
    
    func setData(){
        
        if let objPost = postData{
            lblID.text = "#ID: \(objPost.id ?? 0)"
            lblUserID.text = "#USERID: \(objPost.userId ?? 0)"
            lblTilte.text = objPost.title
            lblDesc.text = objPost.body
        }
        
    }
    
    //MARK: - Action

    @IBAction func btnCloseClicked(_ sender : UIButton){
        self.onCloseClick?()
    }

}

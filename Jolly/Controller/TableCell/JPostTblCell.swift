//
//  JPostTblCell.swift
//  Jolly
//
//  Created by Apple on 26/04/24.
//

import UIKit

class JPostTblCell: UITableViewCell {
    
    //MARK: - Outlet
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblUserID: UILabel!
    @IBOutlet weak var lblTilte: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Custom
    
    func setData(postData : JPostModel?){
        
        if let objPost = postData{
            lblID.text = "#ID: \(objPost.id ?? 0)"
            lblUserID.text = "#USERID: \(objPost.userId ?? 0)"
            lblTilte.text = objPost.title
            lblDesc.text = objPost.body
        }
        
    }

}

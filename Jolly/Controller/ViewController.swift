//
//  ViewController.swift
//  Jolly
//
//  Created by Apple on 26/04/24.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Outlet
    
    @IBOutlet weak var tblPost: UITableView!
    
    //MARK: - Properties
    
    var jPostViewModel: JPostViewModel?
    let pagingSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    //MARK: - Viewcontroller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup viewModel
        jPostViewModel = JPostViewModel.init(self)
        setupLoadMoreDataSpinner()

    }
    
    func setupLoadMoreDataSpinner(){
        pagingSpinner.startAnimating()
        pagingSpinner.hidesWhenStopped = true
        tblPost.tableFooterView = pagingSpinner
    }


}


//MARK: - TableView delegate method


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jPostViewModel?.arrJPost.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JPostTblCell") as! JPostTblCell
        cell.setData(postData: jPostViewModel?.arrJPost[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostDetailsVC") as! PostDetailsVC
        vc.postData =  jPostViewModel?.arrJPost[indexPath.row]
        vc.onCloseClick = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
}

//MARK: - ViewModel delegate method

extension ViewController : JPostViewModelDelegate{
    
    func reloadTable() {
        tblPost.reloadData()
        jPostViewModel?.page += 1
        pagingSpinner.stopAnimating()
    }
    
}


extension ViewController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let Y = scrollView.contentOffset.y
           let scrollViewContentHeight = scrollView.contentSize.height
           if Y > scrollViewContentHeight - scrollView.frame.height {
               jPostViewModel?.getPostDataAPI()
               pagingSpinner.startAnimating()
           }
       }
    
}

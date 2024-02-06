//
//  SideMenuVC.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 03/02/24.
//

import UIKit

class SideMenuVC: UIViewController {

   
    
    @IBOutlet weak var logoImgViw: UIImageView!
    @IBOutlet weak var dataTV: UITableView!
    
    let menuList = ["API Setup","Orders","Settings","Terms & Conditions"]
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    
    func updateView() {
        logoImgViw.layer.cornerRadius = 10
        dataTV.delegate = self
        dataTV.dataSource = self
        dataTV.estimatedRowHeight = 70
        dataTV.rowHeight = UITableView.automaticDimension
    }


}
extension SideMenuVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = menuList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "Test_VC") as! Test_VC
            self.navigationController?.pushViewController(VC, animated: true)
        } else {
            self.view.makeToast("Coming soon")
        }
    }
    
    
    
    
}

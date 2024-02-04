//
//  Test_VC.swift
//  BagzzDemoApp
//
//  Created by Gopu on 06/02/24.
//

import UIKit
import SideMenuSwift

class Test_VC: UIViewController {

    var viewModel = View_Model()
    
    @IBOutlet weak var dataTV: UITableView! {
        didSet {
            dataTV.register(UINib(nibName: "TestTVCell", bundle: nil), forCellReuseIdentifier: "TestTVCell")
        }
    }
    
    var userDataArr:[GetTestResponseElement] = []
    var tableViewDataSource:TableViewSource<TestTVCell,GetTestResponseElement>?
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    func updateView() {
        dataTV.rowHeight = 70
        viewModel.isLoading = { [unowned self] result  in
            if result {
            self.view.showActivityIndicator()
                
            } else {
            
                self.view.hideActivityIndicator()
                
            }
        
            
        }
        viewModel.updateResponse = { [unowned self] msg  in

            self.view.makeToast(msg)
        }
        
          
        viewModel.didFetchTestData = { [unowned self] result in
        
            if result.isEmpty == false {

                userDataArr = result
                if userDataArr.isEmpty {
                    self.view.makeToast("No Users list")
                } else {
                    updateTableView()

                }

                
            }
        
            
        }
        
        
    }
    
    func updateTableView() {

        self.tableViewDataSource = TableViewSource(cellIdentifier: "TestTVCell", items: userDataArr, configureCell: { (cell , item ) in
            cell.userNameLbl.text = item.column1

        }, selectedCell: { cell , seletecdItem in
            self.view.makeToast("\(seletecdItem.column1)")
        })

        dataTV.delegate = tableViewDataSource
        dataTV.dataSource = tableViewDataSource
        dataTV.isHidden = false
        dataTV.rowHeight = 50
        dataTV.reloadData()
        dataTV.scrollToRow(at: IndexPath(row: userDataArr.count - 1, section: 0), at: .top, animated: true)


    }

    @IBAction func backBtn_Axn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
//        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
//        self.navigationController?.pushViewController(VC, animated: true)

    }
    
    @IBAction func putBtn_Axn(_ sender: UIButton) {
    }
    
    @IBAction func getBtnAxn(_ sender: UIButton) {
        viewModel.fetchTestUserList()

        
    }
    
    @IBAction func postBtn_axn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Alert", message: "Enter a value to POST", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            // do something with textField
            let indexd = self.userDataArr.count + 1
            self.viewModel.postTestUser(userInd: indexd, textValue: textField.text!)

        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Enter Text here"
        })
        self.present(alertController, animated: true, completion: nil)

    }
    
    
    
    
}

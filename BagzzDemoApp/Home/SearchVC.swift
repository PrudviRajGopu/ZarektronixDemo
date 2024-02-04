//
//  SearchVC.swift
//  ZerktronixDemoApp
//
//  Created by Gopu on 03/02/24.
//

import UIKit

class SearchVC: UIViewController {

  
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTV: UITableView! {
        didSet {
            searchTV.register(UINib(nibName: "SearchProductCell", bundle: nil), forCellReuseIdentifier: "SearchProductCell")

        }
    }
    
    var data_Arr:[ProductListResponseElement] = []
    let viewModel = View_Model()
    var tableViewDataSource:TableViewSource<SearchProductCell,ProductListResponseElement>?
    var filterData:[ProductListResponseElement] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    

    func updateView() {
        

        searchBar.delegate = self
        
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
        
          
        viewModel.didFetchList = { [unowned self] result in
        
            if result.isEmpty == false {

                data_Arr = result
                if data_Arr.isEmpty {
                    self.view.makeToast("No Product list")
                } else {
                    updateTableView()

                }

                
            }
        
            
        }
        
        
        viewModel.fetch_Characters_List()
    }
    
    func updateTableView() {

        self.tableViewDataSource = TableViewSource(cellIdentifier: "SearchProductCell", items: data_Arr, configureCell: { (cell , item ) in
            cell.updateCell(model: item)

        }, selectedCell: { cell , seletecdItem in
            self.view.makeToast("\(seletecdItem.title)")
        })

        searchTV.delegate = tableViewDataSource
        searchTV.dataSource = tableViewDataSource
        searchTV.isHidden = false
        searchTV.rowHeight = 180
        searchTV.reloadWithAnimation()

    }
    
    func updateSearchTableView() {

        self.tableViewDataSource = TableViewSource(cellIdentifier: "SearchProductCell", items: filterData, configureCell: { (cell , item ) in
            cell.updateCell(model: item)

        }, selectedCell: { cell , seletecdItem in
            self.view.makeToast("\(seletecdItem.title)")
        })

        searchTV.delegate = tableViewDataSource
        searchTV.dataSource = tableViewDataSource
        searchTV.isHidden = false
        searchTV.reloadWithAnimation()

    }

}
extension SearchVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String){
        if searchText.isEmpty == false {
            filterData = data_Arr.filter({ $0.title.contains(searchText)})
            updateSearchTableView()
        } else {
            filterData = []
            updateTableView()
        }
      
    }
}

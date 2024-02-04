//
//  TableViewSource.swift
//  BagzzDemoApp
//
//  Created by Gopu on 05/02/24.
//

import Foundation
import Foundation
import UIKit

class TableViewSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource, UITableViewDelegate {

    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var selectedCell : (CELL,T) -> () = {_,_ in}

    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> (), selectedCell:@escaping (CELL,T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.selectedCell = selectedCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        cell.tag = indexPath.row
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CELL
        let selectedItem = self.items[indexPath.row]
        self.selectedCell(cell,selectedItem)
    }
    
    
    
}


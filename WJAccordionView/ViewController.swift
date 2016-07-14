//
//  ViewController.swift
//  WJAccordionView
//
//  Created by Willy Jansen on 13/07/2016.
//  Copyright © 2016 willyjansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WJAccordionViewDataSource, UITableViewDataSource, UICollectionViewDataSource {
    
    @IBOutlet weak var accordionView: WJAccordionView?
    
    var colView = UICollectionView()
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfItems() -> Int {
        return 2
    }
    
    func titleForRowAtIndex(index: Int) -> String {
        return "Abc"
    }
    
    func childViewForRowAtIndex(index: Int) -> UIView {
        return UIView()
//        if index == 0 {
//            return colView
//        } else {
//            return tableView
//        }
    }
    
    // MARK: UICollectionViewDataSource
    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func coll

}


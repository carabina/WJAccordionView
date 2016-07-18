//
//  ViewController.swift
//  WJAccordionView
//
//  Created by Willy Jansen on 13/07/2016.
//  Copyright © 2016 willyjansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WJAccordionViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var accordionView: WJAccordionView?
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var compositeView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfItems() -> Int {
        return 3
    }
    
    func titleForRowAtIndex(index: Int) -> String {
        if index == 0 {
            return "Icons"
        } else if index == 1 {
            return "Background"
        } else {
            return "Text"
        }
    }
    
    func childViewForRowAtIndex(index: Int) -> UIView? {
        if index == 0 {
            return collectionView!
        } else if index == 1 {
            return tableView!
        } else {
            return compositeView!
        }
    }
    
    func cornerRadiusForRowAtIndex(index: Int) -> CGFloat {
        return 4.0
    }
    
    func backgroundColorForRowAtIndex(index: Int) -> UIColor? {
        return .lightGrayColor()
    }
    
    func titleColorForRowAtIndex(index: Int) -> UIColor? {
        return .yellowColor()
    }
    
    func titleFontForRowAtIndex(index: Int) -> UIFont? {
        return .boldSystemFontOfSize(18)
    }
    
    func accessoryColorForRowAtIndex(index: Int) -> UIColor? {
        return .darkGrayColor()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 80
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SampleCell", forIndexPath: indexPath)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Tap on collectionView's \(indexPath.item)")
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SampleCell")
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Tap on tableView's \(indexPath.item)")
    }
    
}


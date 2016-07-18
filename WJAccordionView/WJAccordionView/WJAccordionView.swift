//
//  WJAccordionView.swift
//  WJAccordionView
//
//  Created by Willy Jansen on 13/07/2016.
//  Copyright © 2016 willyjansen. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol WJAccordionViewDataSource {
    func numberOfItems() -> Int
    func titleForRowAtIndex(index: Int) -> String
    func childViewForRowAtIndex(index: Int) -> UIView?
    
    // MARK: Style
    
    func cornerRadiusForRowAtIndex(index: Int) -> CGFloat
    func backgroundColorForRowAtIndex(index: Int) -> UIColor?
    func titleFontForRowAtIndex(index: Int) -> UIFont?
    func titleColorForRowAtIndex(index: Int) -> UIColor?
    func accessoryColorForRowAtIndex(index: Int) -> UIColor?
}

class WJAccordionView: UIView, WJAccordionItemViewDataSource, WJAccordionItemViewDelegate {
    
    private static let MIN_WIDTH: CGFloat = 180.0
    private static let MARGIN: CGFloat = 10.0

    @IBOutlet var ibDataSource: NSObject?
    var dataSource: WJAccordionViewDataSource? { return ibDataSource as? WJAccordionViewDataSource }
    
    var highlightIndex: Int?
    var margin = WJAccordionView.MARGIN
    var itemViews: [WJAccordionItemView]? { return subviews as? [WJAccordionItemView] }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clearColor()
    }
    
    override init(frame: CGRect) {
        var width = frame.size.width
        var height = frame.size.height
        
        if width < WJAccordionView.MIN_WIDTH {
            width = WJAccordionView.MIN_WIDTH
        }
        
        if height < WJAccordionItemView.MIN_HEIGHT*2 {
            height = WJAccordionItemView.MIN_HEIGHT*2
        }
        
        super.init(frame: CGRect(origin: frame.origin, size: CGSize(width: width, height: height)))
    }
    
    override func drawRect(rect: CGRect) {
        guard let ds = dataSource else { return }
        
        for index in 0..<ds.numberOfItems() {
            let itemView = WJAccordionItemView()
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.dataSource = self
            itemView.delegate = self
            
            self.addSubview(itemView)
            
            itemView.titleLabel.text = ds.titleForRowAtIndex(index)
            
            itemView.layer.cornerRadius = ds.cornerRadiusForRowAtIndex(index)
            
            if let backgroundColor = ds.backgroundColorForRowAtIndex(index) {
                itemView.backgroundColor = backgroundColor
            }
            
            if let font = ds.titleFontForRowAtIndex(index) {
                itemView.titleLabel.font = font
            }
            
            if let titleColor = ds.titleColorForRowAtIndex(index) {
                itemView.titleLabel.textColor = titleColor
            }
            
            if let accessoryColor = ds.accessoryColorForRowAtIndex(index) {
                itemView.accessoryView.tintColor = accessoryColor
            }
        }
    }
    
    // MARK: WJAccordionItemViewDataSource
    
    func itemViewsCount() -> Int {
        guard let itemsCount = itemViews?.count else { return 0 }
        return itemsCount
    }
    
    func itemViewCurrentIndex(itemView: WJAccordionItemView) -> Int {
        guard let index = itemViews?.indexOf(itemView) else { return Foundation.NSNotFound }
        return index
    }
    
    func itemViewAtIndex(index: Int) -> WJAccordionItemView? {
        guard let itemView = itemViews?[index] else { return nil }
        return itemView
    }
    
    func childViewForItemView(itemView: WJAccordionItemView) -> UIView? {
        guard let ds = dataSource else { return nil }
        guard let index = itemViews?.indexOf(itemView) else { return nil }
        guard let childView = ds.childViewForRowAtIndex(index) else { return nil }
        return childView
    }
    
    // MARK: WJAccordionItemViewDelegate
    
    func itemViewDidFold(itemView: WJAccordionItemView, fold: Bool) {
        if !fold {
            guard let otherItemViews = itemViews?.filter({ $0 != itemView }) else { return }
            for itemView in otherItemViews {
                itemView.fold = true
            }
        }
    }

}

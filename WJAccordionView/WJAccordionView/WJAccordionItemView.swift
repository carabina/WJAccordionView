//
//  WJAccordionItemView.swift
//  WJAccordionView
//
//  Created by Willy Jansen on 13/07/2016.
//  Copyright © 2016 willyjansen. All rights reserved.
//

import UIKit
import SnapKit

protocol WJAccordionItemViewDataSource {
    func itemViewsCount() -> Int
    func itemViewCurrentIndex(itemView: WJAccordionItemView) -> Int
    func itemViewAtIndex(index: Int) -> WJAccordionItemView?
    func childViewForItemView(itemView: WJAccordionItemView) -> UIView?
}

protocol WJAccordionItemViewDelegate {
    func itemViewDidFold(itemView: WJAccordionItemView, fold: Bool)
}

class WJAccordionItemView: UIView {
    
    static let MIN_HEIGHT: CGFloat = 60.0

    lazy var titleLabel: UILabel = {
        let _titleLabel = UILabel()
        _titleLabel.userInteractionEnabled = true
        return _titleLabel
    }()
    
    lazy var accessoryView: UIImageView = {
        let _accessoryView = UIImageView()
        _accessoryView.userInteractionEnabled = true
        _accessoryView.image = UIImage(named: "icon-folded")
        return _accessoryView
    }()
    
    lazy var detailView: UIView = {
        let _detailView = UIView()
        _detailView.userInteractionEnabled = true
        _detailView.backgroundColor = .clearColor()
        return _detailView
    }()
    
    var rowHeight = WJAccordionItemView.MIN_HEIGHT
    
    var dataSource: WJAccordionItemViewDataSource?
    var delegate: WJAccordionItemViewDelegate?
    
    var fold: Bool = true {
        willSet {
            if newValue {
                for childView in detailView.subviews {
                    childView.removeFromSuperview()
                }
                
                detailView.snp_removeConstraints()
                detailView.hidden = true
            }
        }
        didSet {
            if fold != oldValue {
                self.updateConstraints()
            }
            
            if fold {
                accessoryView.image = UIImage(named: "icon-folded")
            } else {
                accessoryView.image = UIImage(named: "icon-expanded")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        addSubview(titleLabel)
        addSubview(accessoryView)
        addSubview(detailView)
        
        titleLabel.snp_remakeConstraints { make in
            make.left.top.right.equalTo(self).inset(UIEdgeInsetsMake(0, 10, 0, 10))
            make.height.equalTo(self.rowHeight)
        }
        
        accessoryView.snp_remakeConstraints { make in
            make.right.equalTo(self)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(32.0)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        titleLabel.addGestureRecognizer(tapGesture)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        guard let ds = dataSource else { return }
        snp_remakeConstraints { make in
            let index = ds.itemViewCurrentIndex(self)
            if index == 0 {
                make.top.equalTo(10.0)
            } else {
                guard let itemView = ds.itemViewAtIndex(index-1) else { return }
                make.top.equalTo(itemView.snp_bottom).offset(10.0)
            }
            
            make.left.equalTo(0.0).offset(10.0)
            make.right.equalTo(superview!.frame.size.width).offset(-10.0)
            
            if fold {
                make.height.equalTo(rowHeight)
            } else {
                make.height.equalTo(superview!.frame.size.height-CGFloat(ds.itemViewsCount())*rowHeight)
            }
        }
        
        UIView.animateWithDuration(0.4, animations: {
            self.superview!.layoutIfNeeded()
        }) { completed in
            if !self.fold {
                self.detailView.snp_remakeConstraints { make in
                    make.top.equalTo(self.rowHeight+10.0)
                    make.left.equalTo(self.titleLabel.snp_left)
                    make.right.equalTo(self.titleLabel.snp_right)
                    make.bottom.equalTo(self.snp_bottom).offset(-10)
                }
                self.detailView.hidden = false
                
                guard let childView = ds.childViewForItemView(self) else { return }
                self.detailView.addSubview(childView)
                childView.snp_remakeConstraints { make in
                    make.edges.equalTo(self.detailView)
                }
            }
        }
    }
    
    // MARK: Events
    
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        fold = !fold
        guard let d = delegate else { return }
        d.itemViewDidFold(self, fold: fold)
    }

}

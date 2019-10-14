//
//  MessageCell.swift
//  Sprackle
//
//  Created by Wilbert Chagula on 2/7/19.
//  Copyright © 2019 Wilbert Chagula. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    let textView: UITextView = {
        let text = UITextView()
        text.text = "SAMPLE TEXT FOR NOW"
        text.font = UIFont.systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor.clear
        text.textColor = UIColor.white
        return text
    }()
    let blueColor:UIColor = UIColor(r: 0, g: 137, b: 249)
    let BubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 0, g: 137, b: 249)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleRightAnchor: NSLayoutConstraint?
    var bubbleLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(BubbleView)
        bubbleRightAnchor = BubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        bubbleRightAnchor?.isActive = true
        bubbleLeftAnchor = BubbleView.leftAnchor.constraint(equalTo: self.leftAnchor)
        bubbleLeftAnchor?.isActive = false
        BubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = BubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        BubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        addSubview(textView)
        textView.leftAnchor.constraint(equalTo: BubbleView.leftAnchor, constant: 10).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: BubbleView.rightAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

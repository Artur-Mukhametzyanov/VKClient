//
//  LikeControl.swift
//  VKClient
//
//  Created by Artur Mukhametzyanov on 10.12.2021.
//

import UIKit

class LikeControl: UIControl {
    
    public var likePressed: Bool = false
    public var likeCount = 0
    let likeImageView = UIImageView()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.text = "0"
        countLabel.textColor = .systemGray
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        return countLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        addGesture()
    }
    
    func setViews() {
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        addSubview(imageView)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
        ])
    }
    
    func configure(isLike: Bool, count: Int) {
        self.likePressed = isLike
        self.likeCount = count
        
        if isLike {
            imageView.image = UIImage(systemName: "heart.fill")
        } else {
            imageView.image = UIImage(systemName: "heart")
        }
        setLikeCounter()
    }
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(controlTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    @objc func controlTapped() {
        likePressed.toggle()
        
        if likePressed {
            imageView.image = UIImage(systemName: "heart.fill")
            likeCount += 1
            setLikeCounter()
        } else {
            imageView.image = UIImage(systemName: "heart")
            likeCount -= 1
            setLikeCounter()
        }
        
        sendActions(for: .valueChanged)
    }
    
    func setLikeCounter() {
        let likeStrings: String?
        
        switch likeCount {
        case 0..<1000:
            likeStrings = String(self.likeCount)
        case 1000..<1_000_000:
            likeStrings = String(self.likeCount/1000) + "K"
        default:
            likeStrings = "-"
        }
        UIView.transition(with: countLabel,
                          duration: 0.25,
                          options: .transitionFlipFromTop) { [unowned self] in
            self.countLabel.text = String(likeStrings ?? "")
        }
    }
}



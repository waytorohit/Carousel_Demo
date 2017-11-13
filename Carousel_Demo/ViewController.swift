//
//  ViewController.swift
//  Carousel_Demo
//
//  Created by Rohit on 10/29/17.
//  Copyright © 2017 Rohit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CarouselCellDelegate {
    
    
    
    
   
    
    @IBOutlet weak var carousel_View: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var trips = [Trip(tripId:	"Paris001",	city:	"Paris",	country:	"France",
    featuredImage:	UIImage(named:	"paris"),	price:	2000,	totalDays:	5,	isLiked:false),
                         
            Trip(tripId:	"Rome001",	city:	"Rome",	country:	"Italy",	featuredImage:
                            UIImage(named:	"rome"),	price:	800,	totalDays:	3,	isLiked:	false),
                         
            Trip(tripId:	"Istanbul001",	city:	"Istanbul",	country:	"Turkey",
            featuredImage:	UIImage(named:	"istanbul"),	price:	2200,	totalDays:	10,	isLiked:false),
            
            Trip(tripId:	"London001",	city:	"London",	country:	"United Kingdom",
                            featuredImage:	UIImage(named:	"london"),	price:	3000,	totalDays:	4,	isLiked:
                            false),
            
            Trip(tripId:	"Sydney001",	city:	"Sydney",	country:	"Australia",
                              featuredImage:	UIImage(named:	"sydney"),	price:	2500,	totalDays:	8,	isLiked:
                            false),
            Trip(tripId:	"Santorini001",	city:	"Santorini",	country:	"Greece",
                              featuredImage:	UIImage(named:	"santorini"),	price:	1800,	totalDays:	7,	isLiked:
                            false),
            Trip(tripId: "Humgary", city: "Budapest", country: "Hungary", featuredImage: UIImage(named: "newyork"), price: 1800, totalDays: 7, isLiked: false),
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carousel_View.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        carousel_View.addSubview(blurEffectView)
        collectionView.backgroundColor = UIColor.clear
        
        // Handling the screen height
        if UIScreen.main.bounds.size.height == 568.0 {
            let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.itemSize = CGSize(width: 250.0, height: 330.0)
        }
        
        collectionView.reloadData()
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCell
        // Configure the cell
        cell.cityLabel.text = trips[indexPath.row].city
        cell.imageView.image = trips[indexPath.row].featuredImage
        cell.countryLabel.text = trips[indexPath.row].country
        cell.isLiked = trips[indexPath.row].isLiked
        cell.daysLabel.text = "\(trips[indexPath.row].totalDays)"
        cell.priceLabel.text = "$\(trips[indexPath.row].price)"
        cell.layer.cornerRadius = 4.0
        cell.delegate = self
        return cell
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }

    
    func didLikeButtonPressed(cell: CarouselCell) {
        if let IndexPath = collectionView.indexPath(for: cell) {
            trips[IndexPath.row].isLiked = trips[IndexPath.row].isLiked ? false:true
            cell.isLiked = trips[IndexPath.row].isLiked
        }
    }
    
}

class CarouselCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var daysLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var likedButton: UIButton!
    
    
    
    var isLiked:Bool = false {
        
        didSet {
            if isLiked {
                likedButton.setImage(UIImage(named: "heartfull"), for: .normal)
            }
            else {
                likedButton.setImage(UIImage(named: "heart"), for: .normal)
            }
        }
        
        
    }
    var delegate:CarouselCellDelegate?
    
    @IBAction func didLikeButtonPressed(cell: CarouselCell) {
        
        delegate?.didLikeButtonPressed(cell: self)
        
    }

    
    
}


protocol CarouselCellDelegate {
    func didLikeButtonPressed(cell: CarouselCell)
}






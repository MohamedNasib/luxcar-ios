//
//  SliderImageCVC.swift
//  Luxcar
//
//  Created by mac on 31/01/2024.
//

import UIKit
import ImageSlideshow
import Alamofire

class SliderImageCVC: UICollectionViewCell, ImageSlideshowDelegate  {
    @IBOutlet weak var imageSlider :ImageSlideshow!
    var context: UIViewController?
    var images: [String] = []
    
    func configure(images: [String] ){
        self.images = images
        configureImageSlider()
    }
    
    func configureImageSlider() {
        imageSlider.slideshowInterval = 5.0
        imageSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        //        imageSlider.pageIndicator = nil
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        imageSlider.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        imageSlider.activityIndicator = DefaultActivityIndicator()
        imageSlider.delegate = self
        
        var values: [AlamofireSource] = []
        
        for item in (images) {
            if let value = AlamofireSource(urlString: item) {
                values.append(value)
            }
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        imageSlider.setImageInputs(values)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlider.addGestureRecognizer(recognizer)
    }
    
    /// to show the tapped  image in full screen
    @objc func didTap() {
        if let context = context {
            let fullScreenController = imageSlider.presentFullScreenController(from: context)
            // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
            fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.medium, color: .white)
        }
    }
    
    
    func configureImage() {
        imageSlider.slideshowInterval = 5.0
        imageSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        //        imageSlider.pageIndicator = nil
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        imageSlider.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        imageSlider.activityIndicator = DefaultActivityIndicator()
        imageSlider.delegate = self
        
        var values: [AlamofireSource] = []
        
        for item in (images) {
            if let value = AlamofireSource(urlString: item) {
                values.append(value)
            }
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        imageSlider.setImageInputs(values)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        imageSlider.addGestureRecognizer(recognizer)
    }
    
    
}

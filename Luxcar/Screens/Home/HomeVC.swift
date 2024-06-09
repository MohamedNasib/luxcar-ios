//
//  HomeVC.swift
//  Luxcar
//
//  Created by mac on 08/01/2024.
//

import UIKit
import Toaster
import ImageSlideshow

class HomeVC: UIViewController, ImageSlideshowDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var img: UIImageView!
    
    var brands: [Brand] = []
    var cars: [Car] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getStaticData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchTVC", bundle: nil), forCellReuseIdentifier: "SearchTVC")
        tableView.register(UINib(nibName: "BrandsTVC", bundle: nil), forCellReuseIdentifier: "BrandsTVC")
        tableView.register(UINib(nibName: "CarTVC", bundle: nil), forCellReuseIdentifier: "CarTVC")
        let nib = UINib(nibName: "TableViewHeader", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "TableViewHeader")
        getBrandList(params: GetBrandListInput(pageNumber: "1", numberOfItems: "100"))
        getCarLatest()
    }
    
    /// to display slider in product details page with array of images
        /// - Parameter product: product containing array of images
//        private func configureImageSlider(images: [String]) {
//    //        slideshow.slideshowInterval = 4.0
//            slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
//            slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
//            slideshow.pageIndicator = nil
//            
//            // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
//            slideshow.activityIndicator = DefaultActivityIndicator()
//            slideshow.delegate = self
//            
//            // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
//            let sources = images.compactMap { (section) -> KingfisherSource? in
//                return KingfisherSource(urlString: section,
//                                        placeholder: UIImage(named: "placeholder"),
//                                        options: [
//    //                                        .transition(.fade(0.2)),
//                                            .onFailureImage(UIImage(named: "placeholder"))
//                                        ])
//            }
//            
//            // Set the sources to the slideshow
//            slideshow.setImageInputs(sources)
//        }
}

extension HomeVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 2:
            return cars.count
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let searchTVC = tableView.dequeueReusableCell(withIdentifier: "SearchTVC", for: indexPath) as? SearchTVC else{return UITableViewCell()}
//            searchTVC.configure(brands: brands)
            return searchTVC
        }
        if indexPath.section == 1 {
            guard let brandCell = tableView.dequeueReusableCell(withIdentifier: "BrandsTVC", for: indexPath) as? BrandsTVC else{return UITableViewCell()}
            brandCell.configure(brands: brands)
            brandCell.context = self
            return brandCell
        } else {
            guard let carCell = tableView.dequeueReusableCell(withIdentifier: "CarTVC", for: indexPath) as? CarTVC else{return UITableViewCell()}
            carCell.configre(car: cars[indexPath.row])
            return carCell
        }
        
        
        
    }
    
        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let vc = SearchVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        else if indexPath.row == 1 {
            
        }
        else{
            let vc = CarDetailsVC()
            vc.car_Id = cars[indexPath.row].id
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 2 {
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableViewHeader") as? TableViewHeader else { return nil }
            view.titleLabel.text = "New Offers"
            return view
        }
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 2 {
            return 56
        }
        return 0
    }


    
}

extension HomeVC {
    func getBrandList(params: GetBrandListInput) {
        K_Network.sendRequest(function: apiService.brandList(params: params), success: { (code, msg, response)  in
            do {
                let dataResult = try response.map(to: DataResult.self)
                self.brands = try response.map(to: [Brand].self, keyPath: "dataResult")
//                self.tableView.invalidateIntrinsicContentSize()
                self.tableView.reloadData()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func getCarLatest() {
        K_Network.sendRequest(function: apiService.getCarLatest, success: { (code, msg, response)  in
            do {
                self.cars = try response.map(to: [Car].self, keyPath: "dataResultWithFavorites._doc")
                self.tableView.reloadData()
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func getStaticData() {
        K_Network.sendRequest(function: apiService.staticData, success: { (code, msg, response)  in
            do {
                let resp = try response.map(to: ResourceResponse.self)
                let image = resp.dataResult[0].images[0]
                self.img.loadImage(from: image)
               
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}

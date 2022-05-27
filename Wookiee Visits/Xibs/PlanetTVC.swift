//
//  PlanetTVC.swift
//  Wookiee Visits
//
//  Created by Uresha Lakshani on 2022-05-26.
//

import UIKit
import SDWebImage

class PlanetTVC: UITableViewCell {

    //MARK: - outlets
    @IBOutlet weak var planetIV: UIImageView!
    @IBOutlet weak var planetNameLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var planetBgView: UIView!
    
    //MARK: - Variables
    var vm = PlanetTVM()
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    //MARK: - Custom Functions
    func setupUI(){
        
        planetBgView.layer.cornerRadius = 10
        planetBgView.layer.borderWidth = 0.5
        planetBgView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    //Set field property
    func configCell(){
        planetNameLbl.text = vm.planet?.name
        climateLbl.text = "Climate :  \(vm.planet?.climate ?? "N/A")"
        planetIV.sd_setImage(with: URL(string: "https://picsum.photos/id/\(vm.imageID ?? 0)/200/300"), placeholderImage: UIImage(named: "placeholder.png"))

    }
  
    
}

//
//  ViewController.swift
//  Wookiee Visits
//
//  Created by Uresha Lakshani on 2022-05-26.
//

import UIKit
import Lottie
import RxSwift
import RxCocoa

class PlanetVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var animationUV: AnimationView!
    @IBOutlet weak var planetTV: UITableView!
    
    //MARK: - Variables
    let vm = PlanetVM()
    let disposeBag = DisposeBag()
    let refreshControl = UIRefreshControl()
    var activityIndicator : UIActivityIndicatorView?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXibs()
        setupDelegate()
        getAllPlanetsList()
        dataSelect()
        dataBind()
        setupRefreshController()
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayAnimationGif()
    }
    
    func registerXibs(){
        planetTV.register(UINib(nibName: "PlanetTVC" , bundle: nil), forCellReuseIdentifier: "PlanetTVC")

    }
    
    // call fuction to display Gif
       func displayAnimationGif(){
           
             //  Set animation content mode
           animationUV.contentMode = .scaleAspectFit
              //Set animation loop mode
           animationUV.loopMode = .loop
              //Adjust animation speed
           animationUV.animationSpeed = 0.5
              //Play animation
           animationUV.play()
           
       }
}

//MARK: - APi Call
extension PlanetVC{
    
    // function to get AllPlanetsList
    func getAllPlanetsList(){
        self.endReferesh()
        self.startAnimating()
        vm.getAllPlanets  { status, code, message in
            self.stopAnimting()
            if status {
                self.vm.isScrolling = true
            }else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

//MARK: - Tableview RX Functions
extension PlanetVC{
    
    //Delegate
    func setupDelegate(){
        planetTV.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    //Data Bind with Tableview
    func dataBind(){
        self.vm.planets.bind(to: planetTV.rx.items(cellIdentifier: "PlanetTVC")){
            (row, planet: Planet, cell: PlanetTVC) in
            cell.vm.planet = planet
            cell.vm.imageID = row + 1
            cell.configCell()
        }.disposed(by: disposeBag)
    }
    
    //Tableview cell select
    func dataSelect(){
        planetTV.rx.itemSelected.subscribe(onNext: { index in
            // navigate to Planet Details view controller
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlanetDetailsVC") as! PlanetDetailsVC
            vc.vm.planet = self.vm.planets.value[index[1]]
            vc.vm.imageID = index[1] + 1
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
}


//MARK: - ScrollView + Pagination
extension PlanetVC: UITableViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == planetTV{
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset

            if distanceFromBottom < height {
                if self.vm.isScrolling{
                    self.vm.isScrolling = false
                    print("page bottom")
                    
                    if  vm.next != nil{
                        vm.page += 1
                        self.getAllPlanetsList()
                    }
                }
            }
        }
    }
}

//MARK: - Indicators
extension PlanetVC{
    
    //refesh controller
    func setupRefreshController(){
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        planetTV.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.vm.page = 1
        self.vm.planets.accept([])
        getAllPlanetsList()
    }
    
    // set up activity indicator
    func setupActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator?.center = self.view.center
        activityIndicator?.color = .white
        if let indicator = activityIndicator{
            view.addSubview(indicator)
        }
    }
    
    func endReferesh(){
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    func startAnimating(){
        DispatchQueue.main.async {
            self.activityIndicator?.startAnimating()
        }
    }
    
    func stopAnimting(){
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
        }
    }
}

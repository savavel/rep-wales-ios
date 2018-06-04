//
//  TutorialViewController.swift
//  UIPageViewController Post
//
//  Created by Jeffrey Burt on 2/3/16.
//  Copyright © 2016 Seven Even. All rights reserved.
//

import UIKit
import SideMenu
import ElasticTransition
import Instructions

class TutorialViewController: UIViewController,CoachMarksControllerDataSource,CoachMarksControllerDelegate {
    
    
    
    @IBOutlet weak var viewMapBTN: UIView!
    @IBOutlet weak var viewRepBTN: UIView!
    
    
    @IBOutlet weak var mapBTN: UIButton!
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var btnWallet: UIButton!
    @IBOutlet weak var btnLiveFeed: UIButton!
    
    @IBOutlet weak var repBTN: UIButton!
    @IBOutlet weak var basketCount: UILabel!
    @IBOutlet weak var basketBTN: UIButton!
    @IBOutlet weak var topView: GradiantView!
    
    var transition = ElasticTransition()
    

    
    
    //Tour guide methodes and delegates
    
    let coachMarksController = CoachMarksController()
    
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 3
    }
    
    
    
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        
        var coachMark : CoachMark
        
        switch(index) {
            
        case 0:
            coachMark = coachMarksController.helper.makeCoachMark(for: self.repBTN)
            coachMark.arrowOrientation = .top
            
        case 1:
            coachMark = coachMarksController.helper.makeCoachMark(for: self.mapBTN)
            coachMark.arrowOrientation = .top
            
        case 2:
            coachMark = coachMarksController.helper.makeCoachMark(for: self.basketBTN)
            coachMark.arrowOrientation = .top
            
            
        default:
            coachMark = coachMarksController.helper.makeCoachMark()
            
            
        }
        
        return coachMark
        
    }
    
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        
        let coachMarkBodyView = CustomCoachMarkBodyView()
        var coachMarkArrowView: CustomCoachMarkArrowView? = nil
        
        var width: CGFloat = 0.0
        
        switch(index) {
        case 0:
            coachMarkBodyView.hintLabel.text = "Press on Rep for more options."
            coachMarkBodyView.highlighted = true
            coachMarkBodyView.nextButton.setTitle("ok!", for: .normal)
            if let repBTN = self.repBTN {
                width = repBTN.bounds.width
            }
        case 1:
            coachMarkBodyView.hintLabel.text = "Use map for nearby venues."
            //  coachMarkBodyView.highlighted = true
            coachMarkBodyView.nextButton.setTitle("ok!", for: .normal)
            if let mapBTN = self.mapBTN {
                width = mapBTN.bounds.width
            }
        case 2:
            coachMarkBodyView.hintLabel.text = "Check what's in your basket."
            //  coachMarkBodyView.highlighted = true
            coachMarkBodyView.nextButton.setTitle("ok!", for: .normal)
            coachMarkBodyView.nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
            if let basketBTN = self.basketBTN {
                width = basketBTN.bounds.width
            }
            
            
            
            
        default: break
            
            
        }
        
        
        //draw the arrow
        if let arrowOrientation = coachMark.arrowOrientation {
            coachMarkArrowView = CustomCoachMarkArrowView(orientation: arrowOrientation)
            
            // If the view is larger than 1/3 of the overlay width, we'll shrink a bit the width
            // of the arrow.
            let oneThirdOfWidth = self.view.window!.frame.size.width / 3
            let adjustedWidth = width >= oneThirdOfWidth ? width - 2 * coachMark.horizontalMargin : width
            
            coachMarkArrowView!.plate.addConstraint(NSLayoutConstraint(item: coachMarkArrowView!.plate, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: adjustedWidth))
        }
        
        
        return (bodyView: coachMarkBodyView, arrowView: coachMarkArrowView)
    }
    
    
    func nextPressed(sender: UIButton!) {
        print("Button tapped")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startNext"), object: nil, userInfo: nil)

    }
    
    
    
    
    @IBAction func basketAction(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Chart")
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    
    var animationStarted : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        
    }
    override func viewDidAppear(_ animated: Bool) {
        basketCount.text = "\(MarcketChart.chartArray.count)"
        
        
    
        
    }
    
    
    @IBAction func sideMenuAction(_ sender: AnyObject) {
        // present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
        
        
        
    }
    @IBAction func RepAction(_ sender: AnyObject) {
        
        transition.edge = .bottom
        transition.startingPoint = sender.center
        performSegue(withIdentifier: "settings", sender: self)
        
        
    }
    
    fileprivate func setupSideMenu() {
        let v  : menuViewController =  storyboard!.instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
        
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: v)
        menuLeftNavigationController.leftSide = true
        
        menuLeftNavigationController.navigationBar.isHidden = true
        
        SideMenuManager.menuPushStyle = .defaultBehavior
        SideMenuManager.menuRightNavigationController = menuLeftNavigationController
        SideMenuManager.menuLeftNavigationController = nil
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        SideMenuManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.menuFadeStatusBar = false
        
        SideMenuManager.menuAnimationBackgroundColor = UIColor.gray
        SideMenuManager.menuShadowRadius = 0.0
        
        SideMenuManager.menuDismissOnPush = true
        SideMenuManager.menuAllowPushOfSameClassTwice = false
        SideMenuManager.menuWidth = 200
    }
    
    
    @IBAction func mapAction(_ sender: Any) {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        //self.show(newViewController, sender: true)
        self.present(newViewController, animated: true, completion: nil)
        
        
        /*   let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapBox") as! MapBoxViewController
         self.show(newViewController, sender: true)
         */
        
        
        
    }
    
    //    override var prefersStatusBarHidden: Bool {
    //        return true
    //    }
    
    
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    var currentIndex = 0
    
    
    func viewMapBTNAction(sender : UITapGestureRecognizer) {
        // Do what you want

        let storyBoard: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        //self.show(newViewController, sender: true)
        self.present(newViewController, animated: true, completion: nil)
        
        
    }
    
    func viewRepBTNAction(sender : UITapGestureRecognizer) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Chart")
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.viewMapBTNAction(sender:)))
        self.viewMapBTN.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.viewRepBTNAction(sender:)))
        self.viewRepBTN.addGestureRecognizer(gesture2)
        
      
        
        
        
        self.coachMarksController.dataSource = self
        
     //
        
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
             self.coachMarksController.start(on: self)
        }
        
        
        
        
        //  setupSideMenu()
        
        btnWallet.setTitleColor(UIColor.white, for: .normal)
        btnLiveFeed.setTitleColor(UIColor(hexString: "#00E4FF"), for: .normal)
        
        // Shadow and Radius
        
        // btnWallet.addShadowView(width: 4, height: 4, Opacidade: 1, maskToBounds: true, radius: 6)
        
        currentIndex = 0
        
        
        btnWallet.layer.cornerRadius = 12
        btnLiveFeed.layer.cornerRadius = 12
        
        
        
        btnWallet.layer.shadowOpacity = 0.9
        btnWallet.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        btnWallet.layer.shadowRadius = 6
        btnWallet.layer.shadowColor = UIColor(hexString : "#00779A").cgColor
        
        
        btnLiveFeed.layer.shadowOpacity = 0.9
        btnLiveFeed.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        btnLiveFeed.layer.shadowRadius = 6
        btnLiveFeed.layer.shadowColor = UIColor(hexString : "#00779A").cgColor
        
        //
        //        //transition customization
        transition.sticky = true
        transition.showShadow = true
        transition.panThreshold = 0.3
        transition.radiusFactor = 8
        transition.transformType = .translateMid
        
        
        
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .custom
        
        
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
        
        
        
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        
        if ( currentIndex != 1 ) {
            tutorialPageViewController?.scrollToViewController(index: 1)
            currentIndex = 1
        }
        
        
        
    }
    @IBAction func didTapBackButton(_ sender: UIButton) {
        if ( currentIndex != 0 ) {
            tutorialPageViewController?.scrollToViewController(index: 0)
            currentIndex = 0
            
        }
        
    }
    @IBAction func liveFeedAction(_ sender: Any) {
        
        
        btnWallet.setTitleColor(UIColor.white, for: .normal)
        btnLiveFeed.setTitleColor(UIColor(hexString: "#00E4FF"), for: .normal)
        
    }
    @IBAction func walletAction(_ sender: Any) {
        
        
        btnWallet.setTitleColor(UIColor(hexString: "#00E4FF"), for: .normal)
        btnLiveFeed.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        //  tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}



extension TutorialViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        //  pageControl.numberOfPages = count
        print("******************************** count  \(count)")
        
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        //pageControl.currentPage = index
        print("******************************** index  \(index)")
        currentIndex = index
        
        if (index == 0 ){
            btnWallet.setTitleColor(UIColor.white, for: .normal)
            btnLiveFeed.setTitleColor(UIColor(hexString: "#00E4FF"), for: .normal)
        }
        if (index == 1 ){
            btnWallet.setTitleColor(UIColor(hexString: "#00E4FF"), for: .normal)
            btnLiveFeed.setTitleColor(UIColor.white, for: .normal)
        }
        
    }
    
}

//
//  LiveFeedViewController.swift
//  rep
//
//  Created by MacBook Pro on 30/08/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit
import KeychainSwift
import Instructions

struct MarcketChart {
    static var chartArray : [Chart] = []
}

class LiveFeedViewController: UIViewController,CoachMarksControllerDataSource,CoachMarksControllerDelegate {
    let keychain = KeychainSwift()
//LiveFeedViewController
    @IBOutlet weak var unableView1Menu: UIView!
    @IBOutlet weak var unableView2Menu: UIView!
    @IBOutlet weak var unableView3Menu: UIView!
    @IBOutlet weak var unableView4Menu: UIView!
    @IBOutlet weak var unableView5Menu: UIView!


    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var view1Menu: UIView!
    
       @IBOutlet weak var view2Menu: UIView!
    
       @IBOutlet weak var view3Menu: UIView!
    
       @IBOutlet weak var view4Menu: UIView!
    
       @IBOutlet weak var view5Menu: UIView!
    @IBOutlet weak var iconsView: UIView!
    
    
    @IBOutlet weak var containerView: UIView!
    private var gradient: CAGradientLayer!

    
     var tutorialPageViewController: LiveFeedPagerViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    var currentIndex = 0
    
    
    
    var mainPager : TutorialPageViewController? = nil
    
    
    
    //Tour guide methodes and delegates
    
    let coachMarksController = CoachMarksController()
    
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 1
    }
    
    
    
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        
        var coachMark : CoachMark
        
        

        coachMark = coachMarksController.helper.makeCoachMark(for: self.iconsView)
        coachMark.arrowOrientation = .top
        
        return coachMark
    }
    
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        
        let coachMarkBodyView = CustomCoachMarkBodyView()
        var coachMarkArrowView: CustomCoachMarkArrowView? = nil
        
        var width: CGFloat = 0.0

        
        coachMarkBodyView.hintLabel.text = "Swipe between tabs for more."
        coachMarkBodyView.highlighted = true
        coachMarkBodyView.nextButton.setTitle("ok!", for: .normal)
        coachMarkBodyView.nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)

      
        if let iconsView = self.iconsView {
            width = iconsView.bounds.width
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
    }
    
    
    func startNext(_ notification: NSNotification) {
   
         self.coachMarksController.start(on: self)
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        
        
     
        //custom the tour guide
        self.coachMarksController.dataSource = self
        self.coachMarksController.overlay.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.0)
        self.coachMarksController.overlay.allowTap = true
       
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.startNext(_:)), name: NSNotification.Name(rawValue: "startNext"), object: nil)
        
        
        
        
         // Do any additional setup after loading the view.
        view1Menu.layer.cornerRadius = 8
        view2Menu.layer.cornerRadius = 8
        view3Menu.layer.cornerRadius = 8
        view4Menu.layer.cornerRadius = 8
        view5Menu.layer.cornerRadius = 8
        
        unableView1Menu.layer.cornerRadius = 8
        unableView2Menu.layer.cornerRadius = 8
        unableView3Menu.layer.cornerRadius = 8
        unableView4Menu.layer.cornerRadius = 8
        unableView5Menu.layer.cornerRadius = 8

        view1Menu.layer.shadowOpacity =  0.7
        view1Menu.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view1Menu.layer.shadowRadius = 6
        view1Menu.layer.shadowColor = UIColor(hexString : "#1D7CE3").cgColor
        
        view2Menu.layer.shadowOpacity =  0.7
        view2Menu.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view2Menu.layer.shadowRadius = 6
        view2Menu.layer.shadowColor = UIColor(hexString : "#1D7CE3").cgColor
        
        view3Menu.layer.shadowOpacity =  0.7
        view3Menu.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view3Menu.layer.shadowRadius = 6
        view3Menu.layer.shadowColor = UIColor(hexString : "#1D7CE3").cgColor
        
        view4Menu.layer.shadowOpacity =  0.7
        view4Menu.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view4Menu.layer.shadowRadius = 6
        view4Menu.layer.shadowColor = UIColor(hexString : "#1D7CE3").cgColor
        
        view5Menu.layer.shadowOpacity =  0.7
        view5Menu.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view5Menu.layer.shadowRadius = 6
        view5Menu.layer.shadowColor = UIColor(hexString : "#1D7CE3").cgColor
        
        
        
        
        
        
        
        unableView1Menu.isHidden = false
        unableView2Menu.isHidden = false
        unableView3Menu.isHidden = false
        unableView4Menu.isHidden = false
        unableView5Menu.isHidden = false

        
        
      
        
        
     
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(self.btn1Action(tapGestureRecognizer:)))
        self.unableView1Menu.isUserInteractionEnabled = true
        self.unableView1Menu.addGestureRecognizer(tapGestureRecognizer1)
        
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.btn2Action(tapGestureRecognizer:)))
        self.unableView2Menu.isUserInteractionEnabled = true
        self.unableView2Menu.addGestureRecognizer(tapGestureRecognizer2)
        
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(self.btn3Action(tapGestureRecognizer:)))
        self.unableView3Menu.isUserInteractionEnabled = true
        self.unableView3Menu.addGestureRecognizer(tapGestureRecognizer3)
        
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(self.btn4Action(tapGestureRecognizer:)))
        self.unableView4Menu.isUserInteractionEnabled = true
        self.unableView4Menu.addGestureRecognizer(tapGestureRecognizer4)
        
        
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(self.btn5Action(tapGestureRecognizer:)))
        self.unableView5Menu.isUserInteractionEnabled = true
        self.unableView5Menu.addGestureRecognizer(tapGestureRecognizer5)
        
        
        /********* BTN1 Clicked **********/
        
        print("****** Clicked B1")
        unableView1Menu.isHidden = true
        unableView2Menu.isHidden = false
        unableView3Menu.isHidden = false
        unableView4Menu.isHidden = false
        unableView5Menu.isHidden = false
        
        
        view1Menu.layer.shadowOpacity =  0.7
        view1Menu.layer.shadowRadius = 6
        
        view2Menu.layer.shadowOpacity =  0.7
        view2Menu.layer.shadowRadius = 6
        
        view3Menu.layer.shadowOpacity =  0.7
        view3Menu.layer.shadowRadius = 6
        
        view4Menu.layer.shadowOpacity =  0.7
        view4Menu.layer.shadowRadius = 6
        
        view5Menu.layer.shadowOpacity =  0.7
        view5Menu.layer.shadowRadius = 6
        
        /*******************************************/

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func btn1Action(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("****** Clicked B1")
        unableView1Menu.isHidden = true
        unableView2Menu.isHidden = false
        unableView3Menu.isHidden = false
        unableView4Menu.isHidden = false
        unableView5Menu.isHidden = false
        
        
        view1Menu.layer.shadowOpacity =  0.7
        view1Menu.layer.shadowRadius = 6
        
        view2Menu.layer.shadowOpacity =  0.7
        view2Menu.layer.shadowRadius = 6
        
        view3Menu.layer.shadowOpacity =  0.7
        view3Menu.layer.shadowRadius = 6
        
        view4Menu.layer.shadowOpacity =  0.7
        view4Menu.layer.shadowRadius = 6
        
        view5Menu.layer.shadowOpacity =  0.7
        view5Menu.layer.shadowRadius = 6
        
        if ( currentIndex != 0 ) {
            tutorialPageViewController?.scrollToViewController(index: 0)
            currentIndex = 0
            
        }
    }
    
    func btn2Action(tapGestureRecognizer: UITapGestureRecognizer)
    {
        unableView1Menu.isHidden = false
        unableView2Menu.isHidden = true
        unableView3Menu.isHidden = false
        unableView4Menu.isHidden = false
        unableView5Menu.isHidden = false
        
        
        view1Menu.layer.shadowOpacity =  0.7
        view1Menu.layer.shadowRadius = 6
        
        view2Menu.layer.shadowOpacity =  0.7
        view2Menu.layer.shadowRadius = 6
        
        view3Menu.layer.shadowOpacity =  0.7
        view3Menu.layer.shadowRadius = 6
        
        view4Menu.layer.shadowOpacity =  0.7
        view4Menu.layer.shadowRadius = 6
        
        view5Menu.layer.shadowOpacity =  0.7
        view5Menu.layer.shadowRadius = 6
        
        if ( currentIndex != 1 ) {
            tutorialPageViewController?.scrollToViewController(index: 1)
            currentIndex = 1
            
        }
        
      
    }
    
func btn3Action(tapGestureRecognizer: UITapGestureRecognizer)
{
        unableView1Menu.isHidden = false
        unableView2Menu.isHidden = false
        unableView3Menu.isHidden = true
        unableView4Menu.isHidden = false
        unableView5Menu.isHidden = false
        
    
    view1Menu.layer.shadowOpacity =  0.7
    view1Menu.layer.shadowRadius = 6
    
    view2Menu.layer.shadowOpacity =  0.7
    view2Menu.layer.shadowRadius = 6
    
    view3Menu.layer.shadowOpacity =  0.7
    view3Menu.layer.shadowRadius = 6
    
    view4Menu.layer.shadowOpacity =  0.7
    view4Menu.layer.shadowRadius = 6
    
    view5Menu.layer.shadowOpacity =  0.7
    view5Menu.layer.shadowRadius = 6
    
    if ( currentIndex != 2 ) {
        tutorialPageViewController?.scrollToViewController(index: 2)
        currentIndex = 2
        
    }
    }

func btn4Action(tapGestureRecognizer: UITapGestureRecognizer)
{
        unableView1Menu.isHidden = false
        unableView2Menu.isHidden = false
        unableView3Menu.isHidden = false
        unableView4Menu.isHidden = true
        unableView5Menu.isHidden = false
        
    
    view1Menu.layer.shadowOpacity =  0.7
    view1Menu.layer.shadowRadius = 6
    
    view2Menu.layer.shadowOpacity =  0.7
    view2Menu.layer.shadowRadius = 6
    
    view3Menu.layer.shadowOpacity =  0.7
    view3Menu.layer.shadowRadius = 6
    
    view4Menu.layer.shadowOpacity =  0.7
    view4Menu.layer.shadowRadius = 6
    
    view5Menu.layer.shadowOpacity =  0.7
    view5Menu.layer.shadowRadius = 6
    
    if ( currentIndex != 3 ) {
        tutorialPageViewController?.scrollToViewController(index: 3)
        currentIndex = 3
        
    }
    
    }
    

func btn5Action(tapGestureRecognizer: UITapGestureRecognizer)
{
        unableView1Menu.isHidden = false
        unableView2Menu.isHidden = false
        unableView3Menu.isHidden = false
        unableView4Menu.isHidden = false
        unableView5Menu.isHidden = true
        
    
    view1Menu.layer.shadowOpacity =  0.7
    view1Menu.layer.shadowRadius = 6
    
    view2Menu.layer.shadowOpacity =  0.7
    view2Menu.layer.shadowRadius = 6
    
    view3Menu.layer.shadowOpacity =  0.7
    view3Menu.layer.shadowRadius = 6
    
    view4Menu.layer.shadowOpacity =  0.7
    view4Menu.layer.shadowRadius = 6
    
    view5Menu.layer.shadowOpacity =  0.7
    view5Menu.layer.shadowRadius = 6
    if ( currentIndex != 4 ) {
        tutorialPageViewController?.scrollToViewController(index: 4)
        currentIndex = 4
        
    }
    
    }
    
    

    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? LiveFeedPagerViewController {
            self.tutorialPageViewController = tutorialPageViewController
            self.tutorialPageViewController?.clients = AppDelegate.clients
        }
    }
    //LiveFeedPagerViewController

}

extension LiveFeedViewController: LiveFeedPagerViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: LiveFeedPagerViewController,
                                    didUpdatePageCount count: Int) {
        //  pageControl.numberOfPages = count
        print("******************************** count  \(count)")
        
        
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: LiveFeedPagerViewController,
                                    didUpdatePageIndex index: Int) {
        //pageControl.currentPage = index
        print("******************************** index  \(index)")
        currentIndex = index
        
        
        if (index == 0 ){
            print("****** Clicked B1")
            unableView1Menu.isHidden = true
            unableView2Menu.isHidden = false
            unableView3Menu.isHidden = false
            unableView4Menu.isHidden = false
            unableView5Menu.isHidden = false
            
            
            view1Menu.layer.shadowOpacity =  0.7
            view1Menu.layer.shadowRadius = 6
            
            view2Menu.layer.shadowOpacity =  0.7
            view2Menu.layer.shadowRadius = 6
            
            view3Menu.layer.shadowOpacity =  0.7
            view3Menu.layer.shadowRadius = 6
            
            view4Menu.layer.shadowOpacity =  0.7
            view4Menu.layer.shadowRadius = 6
            
            view5Menu.layer.shadowOpacity =  0.7
            view5Menu.layer.shadowRadius = 6
        }
        if (index == 1 ){
            unableView1Menu.isHidden = false
            unableView2Menu.isHidden = true
            unableView3Menu.isHidden = false
            unableView4Menu.isHidden = false
            unableView5Menu.isHidden = false
            
            
            
            view1Menu.layer.shadowOpacity =  0.7
            view1Menu.layer.shadowRadius = 6
            
            view2Menu.layer.shadowOpacity =  0.7
            view2Menu.layer.shadowRadius = 6
            
            view3Menu.layer.shadowOpacity =  0.7
            view3Menu.layer.shadowRadius = 6
            
            view4Menu.layer.shadowOpacity =  0.7
            view4Menu.layer.shadowRadius = 6
            
            view5Menu.layer.shadowOpacity =  0.7
            view5Menu.layer.shadowRadius = 6
        }
        if (index == 2 ){
            unableView1Menu.isHidden = false
            unableView2Menu.isHidden = false
            unableView3Menu.isHidden = true
            unableView4Menu.isHidden = false
            unableView5Menu.isHidden = false
            
            
            view1Menu.layer.shadowOpacity =  0.7
            view1Menu.layer.shadowRadius = 6
            
            view2Menu.layer.shadowOpacity =  0.7
            view2Menu.layer.shadowRadius = 6
            
            view3Menu.layer.shadowOpacity =  0.7
            view3Menu.layer.shadowRadius = 6
            
            view4Menu.layer.shadowOpacity =  0.7
            view4Menu.layer.shadowRadius = 6
            
            view5Menu.layer.shadowOpacity =  0.7
            view5Menu.layer.shadowRadius = 6
        }
        if (index == 3 ){
            unableView1Menu.isHidden = false
            unableView2Menu.isHidden = false
            unableView3Menu.isHidden = false
            unableView4Menu.isHidden = true
            unableView5Menu.isHidden = false
            
            
            view1Menu.layer.shadowOpacity =  0.7
            view1Menu.layer.shadowRadius = 6
            
            view2Menu.layer.shadowOpacity =  0.7
            view2Menu.layer.shadowRadius = 6
            
            view3Menu.layer.shadowOpacity =  0.7
            view3Menu.layer.shadowRadius = 6
            
            view4Menu.layer.shadowOpacity =  0.7
            view4Menu.layer.shadowRadius = 6
            
            view5Menu.layer.shadowOpacity =  0.7
            view5Menu.layer.shadowRadius = 6
        }
        if (index == 4 ){
            unableView1Menu.isHidden = false
            unableView2Menu.isHidden = false
            unableView3Menu.isHidden = false
            unableView4Menu.isHidden = false
            unableView5Menu.isHidden = true
            
            
            view1Menu.layer.shadowOpacity =  0.7
            view1Menu.layer.shadowRadius = 6
            
            view2Menu.layer.shadowOpacity =  0.7
            view2Menu.layer.shadowRadius = 6
            
            view3Menu.layer.shadowOpacity =  0.7
            view3Menu.layer.shadowRadius = 6
            
            view4Menu.layer.shadowOpacity =  0.7
            view4Menu.layer.shadowRadius = 6
            
            view5Menu.layer.shadowOpacity =  0.7
            view5Menu.layer.shadowRadius = 6
        }
        
        
        
    }
    
}

 

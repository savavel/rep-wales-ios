//
//  DetailsLiveFeed2ViewController.swift
//  rep
//
//  Created by MacBook Pro on 30/08/2017.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class DetailsLiveFeed2ViewController: UIViewController {
    @IBOutlet weak var viewBtnPromotion: UIView!
    @IBOutlet weak var viewBtnDrink: UIView!
    @IBOutlet weak var viewBtnTicket: UIView!
    @IBOutlet weak var viewBtnFood: UIView!
    @IBOutlet weak var viewBtnMag: UIView!
    
    @IBOutlet weak var imageViewAnimation: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    var client : Client? = nil
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var currentBasket: UILabel!
    @IBOutlet weak var venuName: UILabel!
    var currentIndex = 0

    @IBOutlet weak var viewBasket: UIView!
    @IBOutlet weak var viewClose: UIView!
    @IBOutlet weak var shoppingCard: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        venuName.text = client?.name
        venuName.heroID = client?.name
        
        bottomView.layer.cornerRadius = 15
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowRadius = 6
        bottomView.layer.shadowColor = UIColor.black.cgColor
        
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.viewCloseAction(sender:)))
        self.viewClose.addGestureRecognizer(gesture)
 
        //viewBasketAction
          let gesture2 = UITapGestureRecognizer(target: self, action:  #selector (self.viewBasketAction(sender:)))
        self.viewBasket.addGestureRecognizer(gesture2)

        
    }
    
    
    func viewCloseAction(sender : UITapGestureRecognizer){
        
       
        self.dismiss(animated: true, completion: nil)
        
    }
    func viewBasketAction(sender : UITapGestureRecognizer){
        //viewBasket
        if(MarcketChart.chartArray.count == 0) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "EmptyChart")
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }else {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Chart")
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //shoppingCard.setTitle("\(MarcketChart.chartArray.count)", for: .normal)
        currentBasket.text = "\(MarcketChart.chartArray.count)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /***************************Pager**********************/
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    var isBusy : Bool = false
    
    var currentIndexPager = 1
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func marketBtn(_ sender: Any) {

        
        if(MarcketChart.chartArray.count == 0) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "EmptyChart")
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }else {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Acceuil", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Chart")
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
            
        }
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        
//        // Do any additional setup after loading the view.
//        DispatchQueue.global(qos: .background).async { // 1
//
//            DispatchQueue.main.async { // 2
//
//                self.startAnimationCloud1()
//                self.startAnimationCloud2()
//                self.startAnimationCloud3()
//            }
//        }
        
    }
    @IBAction func btn1Action(_ sender: Any) {
        
        if (isBusy == false ){
            
                        isBusy = true
        /**** CHANGE ANIMATION TAB *****/
        if (currentIndexPager > 1){
            UIView.animate(withDuration: 0.5, animations: {
                
                if (self.currentIndexPager == 2){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(1))
                }
                if (self.currentIndexPager == 3){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(2))
                }
                if (self.currentIndexPager == 4){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(3))
                }
                if (self.currentIndexPager == 5){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(4))
                }
            }) { (b) in
                print("done animation")
                print(b)
                
                
            
                
                
                self.btn1.setImage( UIImage(named: "promotion_over"), for: .normal )
                self.btn2.setImage( UIImage(named: "wine_under"), for: .normal )
                self.btn3.setImage( UIImage(named: "ticket_under"), for: .normal )
                self.btn4.setImage( UIImage(named: "food_under"), for: .normal )
                self.btn5.setImage( UIImage(named: "magasin"), for: .normal )
                
                
                
                
                self.currentIndexPager = 1
                
                self.isBusy = false
                if ( self.currentIndex != 0 ) {
                    self.tutorialPageViewController?.scrollToViewController(index: 0)
                    self.currentIndex = 0
                    
                }
                /***** Animation Fade in @ out ******/
            
                self.viewBtnPromotion.alpha = 0
                self.viewBtnPromotion.fadeIn(completion: {
                    (finished: Bool) -> Void in
                    /*self.viewBtnPromotion.fadeOut(completion: {
                        (finished: Bool) -> Void in
                        //self.viewBtnPromotion.alpha = 1
                    })*/
                })
                
                
            }
        }
        
        
        
        /** END CHANGE ANIMATION TAB ***/
        /*
        if ( currentIndexPager != 1){
            
            if (currentIndexPager > 1){
                UIView.animate(withDuration: 0.5, animations: {
                    
                    if (self.currentIndexPager == 2){
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(1))
                    }
                    if (self.currentIndexPager == 3){
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(2))
                    }
                    if (self.currentIndexPager == 4){
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(3))
                    }
                    if (self.currentIndexPager == 5){
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(4))
                    }
                }) { (b) in
                    print("done animation")
                    print(b)
                    
                    
                    
                    
                    
                    self.btn1.setImage( UIImage(named: "promotion_over"), for: .normal )
                    self.btn2.setImage( UIImage(named: "wine_under"), for: .normal )
                    self.btn3.setImage( UIImage(named: "food_under"), for: .normal )
                    self.btn4.setImage( UIImage(named: "ticket_under"), for: .normal )
                    self.btn5.setImage( UIImage(named: "magasin"), for: .normal )
         
         
         ///fuck yoiuuuuuuuuuuuu
                    
                    
                    
                    
                    self.currentIndexPager = 1
                    
                    
                }
            }
            
            
        }
        */
         }
        
    }
    @IBAction func btn2Action(_ sender: Any) {
        /**** CHANGE ANIMATION TAB *****/
        if (isBusy == false ){
            
            isBusy = true
        UIView.animate(withDuration: 0.5, animations: {
            
            if (self.currentIndexPager > 2){
                if (self.currentIndexPager == 3){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(1))
                }
                if (self.currentIndexPager == 4){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(2))
                }
                if (self.currentIndexPager == 5){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(3))
                }
                
            }
            else {
                
                if (self.currentIndexPager == 1){
                    self.imageViewAnimation.center.x += CGFloat((self.view.frame.width / 5) * CGFloat(1))
                }
            }
            
            
        }) { (b) in
            print("done animation")
            print(b)
            
            
            self.btn1.setImage( UIImage(named: "promotion_under"), for: .normal )
            self.btn2.setImage( UIImage(named: "wine_over"), for: .normal )
            self.btn3.setImage( UIImage(named: "ticket_under"), for: .normal )
            self.btn4.setImage( UIImage(named: "food_under"), for: .normal )
            self.btn5.setImage( UIImage(named: "magasin"), for: .normal )
            
            self.currentIndexPager = 2
            
            self.isBusy = false
            if ( self.currentIndex != 1 ) {
                self.tutorialPageViewController?.scrollToViewController(index: 1)
                self.currentIndex = 1
            }
            
            /***** Animation Fade in @ out ******/
            self.viewBtnDrink.alpha = 0
            self.viewBtnDrink.fadeIn(completion: {
                (finished: Bool) -> Void in
               /* self.viewBtnDrink.fadeOut(completion: {
                    (finished: Bool) -> Void in
                     // self.viewBtnDrink.alpha = 1
                })*/
            })
            
            
            
        }
        }
        /** END CHANGE ANIMATION TAB ***/

    /*
        if ( currentIndexPager != 2){
            UIView.animate(withDuration: 0.5, animations: {
                print("self.view.frame.width ",self.view.frame.width)
                print("self.view.frame.width / 5 ",self.view.frame.width / 5)
                print("currentIndexPager ",self.currentIndexPager)
                if (self.currentIndexPager > 2){
                    if (self.currentIndexPager == 3){
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(1))
                    }
                    if (self.currentIndexPager == 4){
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(2))
                    }
                    if (self.currentIndexPager == 5){
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(3))
                    }
                    
                }
                else {
                      self.imageViewAnimation.center.x += CGFloat((self.view.frame.width / 5) * CGFloat(self.currentIndexPager))
                }
                
              
            }) { (b) in
                print("done animation")
                print(b)
                
                
                self.btn1.setImage( UIImage(named: "promotion_under"), for: .normal )
                self.btn2.setImage( UIImage(named: "wine_over"), for: .normal )
                self.btn3.setImage( UIImage(named: "food_under"), for: .normal )
                self.btn4.setImage( UIImage(named: "ticket_under"), for: .normal )
                self.btn5.setImage( UIImage(named: "magasin"), for: .normal )

                self.currentIndexPager = 2
                
            }
        }
     */
        
    }
    
    @IBAction func btn3Action(_ sender: Any) {
        /**** CHANGE ANIMATION TAB *****/
        if (isBusy == false ){
            
            isBusy = true
        UIView.animate(withDuration: 0.5, animations: {
            
            
            if (self.currentIndexPager > 3){
                
                if (self.currentIndexPager == 4){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(1))
                }
                
                if (self.currentIndexPager == 5){
                    
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(2))
                }
                
            } else {
                if (self.currentIndexPager == 1){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(2) )
                }
                if (self.currentIndexPager == 2){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(1) )
                }
                
            }
            
            
        }) { (b) in
            print("done animation")
            print(b)
            self.btn1.setImage( UIImage(named: "promotion_under"), for: .normal )
            self.btn2.setImage( UIImage(named: "wine_under"), for: .normal )
            self.btn3.setImage( UIImage(named: "ticket_over"), for: .normal )
            self.btn4.setImage( UIImage(named: "food_under"), for: .normal )
            self.btn5.setImage( UIImage(named: "magasin"), for: .normal )
            self.currentIndexPager = 3
            self.isBusy = false
            if ( self.currentIndex != 2 ) {
                self.tutorialPageViewController?.scrollToViewController(index: 2)
                self.currentIndex = 2
            }
            /***** Animation Fade in @ out ******/
            self.viewBtnTicket.alpha = 0
            self.viewBtnTicket.fadeIn(completion: {
                (finished: Bool) -> Void in
                /* self.viewBtnDrink.fadeOut(completion: {
                 (finished: Bool) -> Void in
                 // self.viewBtnDrink.alpha = 1
                 })*/
            })
            
            
        }
        }
        //sdfsfsdfsdf
        
        /** END CHANGE ANIMATION TAB ***/
        
       /*
        
        if ( currentIndexPager != 3){
            UIView.animate(withDuration: 0.5, animations: {

                print("self.view.frame.width ",self.view.frame.width)
                    print("self.view.frame.width / 5 ",self.view.frame.width / 5)
                print("currentIndexPager ",self.currentIndexPager)

                if (self.currentIndexPager > 3){
                    
                    if (self.currentIndexPager == 4){
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(1))
                    }
                    
                    if (self.currentIndexPager == 5){
                        
                        self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(2))
                      }
                    
                } else {
                    if (self.currentIndexPager == 1){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(2) )
                    }
                    if (self.currentIndexPager == 2){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(1) )
                    }
                    
                }
                
               
            }) { (b) in
                print("done animation")
                print(b)
                self.btn1.setImage( UIImage(named: "promotion_under"), for: .normal )
                self.btn2.setImage( UIImage(named: "wine_under"), for: .normal )
                self.btn3.setImage( UIImage(named: "food_over"), for: .normal )
                self.btn4.setImage( UIImage(named: "ticket_under"), for: .normal )
                self.btn5.setImage( UIImage(named: "magasin"), for: .normal )
                self.currentIndexPager = 3
                
            }
        }
        */
    }
    @IBAction func btn4Action(_ sender: Any) {
        /**** CHANGE ANIMATION TAB *****/
        if (isBusy == false ){
            
            isBusy = true
        
        UIView.animate(withDuration: 0.5, animations: {
            if (self.currentIndexPager > 4){
                
                if (self.currentIndexPager == 5){
                    self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(1))
                }
            } else {
                
                if (self.currentIndexPager == 1){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(3) )
                }
                if (self.currentIndexPager == 2){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(2) )
                }
                if (self.currentIndexPager == 3){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(1) )
                }
            }
        }) { (b) in
            print("done animation")
            print(b)
            self.btn1.setImage( UIImage(named: "promotion_under"), for: .normal )
            self.btn2.setImage( UIImage(named: "wine_under"), for: .normal )
            self.btn3.setImage( UIImage(named: "ticket_under"), for: .normal )
            self.btn4.setImage( UIImage(named: "food_over"), for: .normal )
            self.btn5.setImage( UIImage(named: "magasin"), for: .normal )
            self.currentIndexPager = 4
            self.isBusy = false
            if ( self.currentIndex != 3 ) {
                self.tutorialPageViewController?.scrollToViewController(index: 3)
                self.currentIndex = 3
                
            }
            /***** Animation Fade in @ out ******/
            self.viewBtnFood.alpha = 0
            self.viewBtnFood.fadeIn(completion: {
                (finished: Bool) -> Void in
                /* self.viewBtnDrink.fadeOut(completion: {
                 (finished: Bool) -> Void in
                 // self.viewBtnDrink.alpha = 1
                 })*/
            })
        }
        
        
        }
        /** END CHANGE ANIMATION TAB ***/
        /*
        if ( currentIndexPager != 4){
            
            
            UIView.animate(withDuration: 0.5, animations: {
                if (self.currentIndexPager > 4){
                    
                    if (self.currentIndexPager == 5){
                      self.imageViewAnimation.center.x = self.imageViewAnimation.center.x - CGFloat((self.view.frame.width / 5) * CGFloat(1))
                    }
                } else {
                    
                    if (self.currentIndexPager == 1){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(3) )
                    }
                    if (self.currentIndexPager == 2){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(2) )
                    }
                    if (self.currentIndexPager == 3){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(1) )
                    }
                }
            }) { (b) in
                print("done animation")
                print(b)
                self.btn1.setImage( UIImage(named: "promotion_under"), for: .normal )
                self.btn2.setImage( UIImage(named: "wine_under"), for: .normal )
                self.btn3.setImage( UIImage(named: "food_under"), for: .normal )
                self.btn4.setImage( UIImage(named: "ticket_over"), for: .normal )
                self.btn5.setImage( UIImage(named: "magasin"), for: .normal )
                self.currentIndexPager = 4
                
            }
            
            
        }
      */
    }
    @IBAction func btn5Action(_ sender: Any) {
        /**** CHANGE ANIMATION TAB *****/
        if (isBusy == false ){
            
            isBusy = true
        
        UIView.animate(withDuration: 0.5, animations: {
            if (self.currentIndexPager > 5){
                
            } else {
                
                
                if (self.currentIndexPager == 1){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(4) )
                }
                if (self.currentIndexPager == 2){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(3) )
                }
                if (self.currentIndexPager == 3){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(2) )
                }
                if (self.currentIndexPager == 4){
                    self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(1) )
                }
            }
        }) { (b) in
            print("done animation")
            print(b)
            self.btn1.setImage( UIImage(named: "promotion_under"), for: .normal )
            self.btn2.setImage( UIImage(named: "wine_under"), for: .normal )
            self.btn3.setImage( UIImage(named: "ticket_under"), for: .normal )
            self.btn4.setImage( UIImage(named: "food_under"), for: .normal )
            self.btn5.setImage( UIImage(named: "info_over"), for: .normal )
            self.currentIndexPager = 5
            self.isBusy = false
            if ( self.currentIndex != 4 ) {
                self.tutorialPageViewController?.scrollToViewController(index: 4)
                self.currentIndex = 4
                
            }
            /***** Animation Fade in @ out ******/
            self.viewBtnMag.alpha = 0
            self.viewBtnMag.fadeIn(completion: {
                (finished: Bool) -> Void in
                /* self.viewBtnDrink.fadeOut(completion: {
                 (finished: Bool) -> Void in
                 // self.viewBtnDrink.alpha = 1
                 })*/
            })
        }
        
        
        }
        
        
        /** END CHANGE ANIMATION TAB ***/
     /*   if ( currentIndexPager != 5){
            
           
            UIView.animate(withDuration: 0.5, animations: {
                if (self.currentIndexPager > 5){
                    
                } else {
                    
                    
                    if (self.currentIndexPager == 1){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(4) )
                    }
                    if (self.currentIndexPager == 2){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(3) )
                    }
                    if (self.currentIndexPager == 3){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(2) )
                    }
                    if (self.currentIndexPager == 4){
                        self.imageViewAnimation.center.x +=  CGFloat((self.view.frame.width / 5) * CGFloat(1) )
                    }
                }
             }) { (b) in
                print("done animation")
                print(b)
                self.btn1.setImage( UIImage(named: "promotion_under"), for: .normal )
                self.btn2.setImage( UIImage(named: "wine_under"), for: .normal )
                self.btn3.setImage( UIImage(named: "food_under"), for: .normal )
                self.btn4.setImage( UIImage(named: "ticket_under"), for: .normal )
                self.btn5.setImage( UIImage(named: "magasin"), for: .normal )
                self.currentIndexPager = 5
            }
        }
        
     */
        
    }
    
    
    /****************************Pager***********************/
   
    
    func startAnimationCloud1(){
        
        
        UIView.animate(withDuration: 16, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.cloud1.center.x += self.view.bounds.width
        }) { (Bool) in
            //
        }
        
    }
    
    
    func startAnimationCloud2(){
        UIView.animate(withDuration: 16, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.cloud2.center.x -= self.view.bounds.width
        }) { (Bool) in
            //
        }
        
        
    }
    
    
    func startAnimationCloud3(){
        UIView.animate(withDuration: 16, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.cloud3.center.x += self.view.bounds.width
        }) { (Bool) in
            //
        }
        
        
    }
    /**************** PAger 2 *******************/
    
    var tutorialPageViewController: MenuFeedLivePageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? MenuFeedLivePageViewController {
            self.tutorialPageViewController = tutorialPageViewController
            self.tutorialPageViewController?.client = self.client
        }
    }
    
    /****************** Navigation By TABS ***********************/
    
    @IBAction func tab0(_ sender: UIButton) {
        
       
          
        
    }
    @IBAction func tab1(_ sender: UIButton) {
       
      
        
    }
   
    @IBAction func tab2(_ sender: UIButton) {
      
     
         
        
    }
    @IBAction func tab3(_ sender: UIButton) {
   
    
        
    }
    @IBAction func tab4(_ sender: UIButton) {
    
     
        
    }
    /****************** END Navigation By TABS ***********************/

}
extension DetailsLiveFeed2ViewController: MenuFeedLivePageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: MenuFeedLivePageViewController,
                                    didUpdatePageCount count: Int) {
        //  pageControl.numberOfPages = count
        print("******************************** count  \(count)")
        
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: MenuFeedLivePageViewController,
                                    didUpdatePageIndex index: Int) {
        //pageControl.currentPage = index
        print("******************************** index  \(index) ***************** \(currentIndexPager)")
        currentIndex = index
        if (index == 0){
            
           
        }
        if (index == 1){
            

            
        }
        if (index == 2){
            
           
        }
        if (index == 3){
            
          
            
        }
        if (index == 4){
            
          
            
        }
        
        
    }
    
}


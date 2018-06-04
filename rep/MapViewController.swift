//

//  MapViewController.swift

//  rep

//

//  Created by bechir Kaddech on 8/30/17.

//  Copyright © 2017 wales. All rights reserved.

//



import UIKit

import CTSlidingUpPanel


import MapKit



class MapViewController: UIViewController,MKMapViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    private var gradient: CAGradientLayer!
    
    @IBOutlet weak var viewMapBack: UIView!
    
    var indexPathPrevious : IndexPath? = nil
    var indexPathCurrent : IndexPath? = nil
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var txtRounded: UILabel!
    @IBOutlet weak var arrounded: UIView!
    
    let annotation = MKPointAnnotation()
    
    
    
    @IBOutlet weak var mapLayer: UIImageView!
    
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    
    
    
    
    var filterList: [String] = ["food", "drinks","clubs","coffee","bar","Shots","Pizz"]
    
    var feedMap : [StarbucksAnnotation] =  []
    
    var feedMapSearch : [StarbucksAnnotation] =  []
    
    
      var selectedStringCategoryFeed : [String] =  []
    
    
    let currentLocation = CLLocationCoordinate2DMake(AppDelegate.currentLocaitonLatitude, AppDelegate.currentLocaitonLongitude)
    
    
    
  
    
    
    func viewMapBackBTNAction(sender : UITapGestureRecognizer) {
        // Do what you want
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
  

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.map.delegate = self
        
        self.map.showsUserLocation = true
        
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.viewMapBackBTNAction(sender:)))
        self.viewMapBack.addGestureRecognizer(gesture)
        
        
        
        /*********** display current Location ***********/
        
        /*********************** FADE *******************/
        gradient = CAGradientLayer()
        
        
        
        gradient.frame = topCollectionView.bounds
        
        
        
        gradient.startPoint = CGPoint(x: 0,y:0.5)
        
        gradient.endPoint = CGPoint(x: 0.2 ,y: 0.5)
        
        
        
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor ]
        
        // gradient.locations = [0, 0.4 , 0.6, 1]
        topCollectionView.layer.mask = gradient
        /**********END *** FADE *******************/


        arrounded.layer.cornerRadius = 20
        arrounded.layer.shadowColor = UIColor.blue.cgColor
        arrounded.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        arrounded.layer.shadowRadius = 3
        arrounded.layer.shadowOpacity = 0.3
        UIApplication.shared.statusBarStyle = .default


        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLocation.latitude, currentLocation.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
      
        /*let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLocation.latitude, currentLocation.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
         map.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = myLocation
        myAnnotation.title = "Current location"
        
        map.addAnnotation(myAnnotation)*/
         /********** GET DATA With DEFAULT Data  ***********/
        
        
        
        
        
        
        
        findFeedByLagLat(lat: "\(AppDelegate.currentLocaitonLatitude)", lon: "\(AppDelegate.currentLocaitonLongitude)", token: (AppDelegate.currentUser?.token)!)
      /*
        // Get Data with new Data
         let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(self.addAnnotation(gestureRecognizer:)))
         map.addGestureRecognizer(tapGestureRecognizer1)
         map.isUserInteractionEnabled = true
   
      */
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.actionAll(gestureRecognizer:)))
        arrounded.addGestureRecognizer(tapGestureRecognizer2)
        arrounded.isUserInteractionEnabled = true
        
        
        //SelectedButton ALL
        arrounded.backgroundColor = UIColor.init(hexString: "009EFA")
        txtRounded.textColor = UIColor.white
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = topCollectionView.bounds
        //tableView.flashScrollIndicators()
      //  self.topCollectionView.flashScrollIndicators()
        //  topCollectionView.reloadData()
    }
    
    //actionAll
    func actionAll(gestureRecognizer:UITapGestureRecognizer){
        // Filter ALL
        //SelectedButton ALL
        arrounded.backgroundColor = UIColor.init(hexString: "009EFA")
        txtRounded.textColor = UIColor.white
        for k in self.topCollectionView.indexPathsForVisibleItems ?? [] {
            
            let cell = self.topCollectionView.cellForItem(at: k) as! TopCollectionViewCell
            cell.rounded.backgroundColor = UIColor.white
            cell.text.textColor = UIColor.black
            
        }
        print("******************** Filter ALL **************")
        self.feedMapSearch = []
        self.bottomCollectionView.reloadData()
        
        
        for k in self.feedMap {
        
                self.feedMapSearch = self.feedMap
            
        }
        
        self.bottomCollectionView.reloadData()
        removeAllAnnotations()
        addAllFiltredAnnotation()
        
    }
    func addAnnotation(gestureRecognizer:UITapGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: map)
        
        let newCoordinates = map.convert(touchPoint, toCoordinateFrom: map)
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(newCoordinates.latitude, newCoordinates.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        removeAllAnnotations()
        findFeedByLagLat(lat: "\(newCoordinates.latitude)", lon: "\(newCoordinates.longitude)", token: (AppDelegate.currentUser?.token)!)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if (collectionView == bottomCollectionView ) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCell", for: indexPath) as! BottomCollectionViewCell

           print("bottomCollectionView \(indexPath)")
            
            
            cell.ObjFeedMap = feedMapSearch[indexPath.row]
            
            
            
            cell.viewC = self
            
            cell.title.text = feedMapSearch[indexPath.row].name
            
            
            
            
            
            let lat0 : Double =  Double.init("\(currentLocation.latitude)")!
            
            let lon0 : Double =  Double.init("\(currentLocation.longitude)")!
            
            let lat1 : Double =  Double.init("\(feedMapSearch[indexPath.row].latitude)")!
            
            let lon1 : Double =  Double.init("\(feedMapSearch[indexPath.row].longitude)")!
            
            let coordinate0 = CLLocation(latitude: lat0, longitude: lon0)
            
            let coordinate1 = CLLocation(latitude: lat1, longitude: lon1)
            
            let distanceMilles = ( (coordinate1.distance(from: coordinate0)) / 1609.344 )
            
            let distanceInMeters = "\(distanceMilles)"
            
            if let range = distanceInMeters.range(of: ".") {
                
                let firstPart = distanceInMeters[distanceInMeters.startIndex..<range.lowerBound]
                
                print(firstPart) // print Hello
                
                cell.distance.text = "\(firstPart) Miles"
                
            }
            
            
            
            if let url = URL.init(string: feedMapSearch[indexPath.row].image) {
                
                cell.img.downloadedFrom(url: url)
                cell.img.contentMode = .scaleAspectFill
                cell.img.layer.cornerRadius = 10
                cell.img.clipsToBounds = true
            }
            
            
            /************************************/
           
            
            /**********************/
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale =  Locale(identifier: "en_US")
            
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "ha"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            let dateStringWithAMPM = formatter.string(from: Date())
            
            let formatterString = DateFormatter()
            formatterString.calendar = Calendar(identifier: .iso8601)
            formatterString.locale =  Locale(identifier: "en_US")
            
            formatterString.timeZone = TimeZone(secondsFromGMT: 0)
            formatterString.dateFormat = "h"
            formatterString.amSymbol = "AM"
            formatterString.pmSymbol = "PM"
            let dateString = formatterString.string(from: Date())
            
            let currentH : Int = Int(dateString)!
            let currentHoure = dateStringWithAMPM.uppercased()
            
            let dates = ( feedMapSearch[indexPath.row].times).uppercased().components(separatedBy: " - ")
            let timeStart1 : String = dates[0]
            let timess  = dates[1].components(separatedBy: " ")
            let timeClose1 : String = timess[0]
            let timeStart2 : String = timess[1]
            let timeClose2 : String = dates[2]
            let nbHeureStart1 : Int = Int(timeStart1.components(separatedBy: "AM")[0] )!
            print(timeClose1.components(separatedBy: "AM")[0])
            let nbHeureClose1 : Int = Int(timeClose1.components(separatedBy: "PM")[0] )!
            let nbHeureStart2 : Int = Int(timeStart2.components(separatedBy: "PM")[0] )!
            let nbHeureClose2 : Int = Int(timeClose2.components(separatedBy: "PM")[0] )!
            print("currentHoure == \(currentHoure)")
            if (currentHoure.contains("AM")){
                if (((nbHeureStart1 <= currentH) )  ){
                    cell.isOpen.text = "OPEN NOW"
                    cell.isOpen.textColor = UIColor.green
                }else {
                    cell.isOpen.text = "CLOSE NOW"
                    cell.isOpen.textColor = UIColor.red
                }
            }else {
                if (((nbHeureStart2 <= currentH) && (currentH < nbHeureClose2 )) || (currentH < nbHeureClose1 )  ){
                    cell.isOpen.text = "OPEN NOW"
                    cell.isOpen.textColor = UIColor.green


                }else {
                    cell.isOpen.text = "CLOSE NOW"
                    cell.isOpen.textColor = UIColor.red

                }
            }
            /**************************/
            
 
            
            
            return cell
            
        }
        
        if (collectionView == topCollectionView ) {
            
            print("topCollectionView \(indexPath)")
            
            var cell : TopCollectionViewCell? = nil
            
            
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath) as? TopCollectionViewCell
            
            
            
            cell?.text.text = filterList[indexPath.row]
            
            
            
            
            
            
            
            return cell!
            
            
            
        }
        
        return UICollectionViewCell()
        
        
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        
        return 1
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        if (collectionView == bottomCollectionView) {
            
            return self.feedMapSearch.count
            
        }
        
        if (collectionView == topCollectionView) {
            
            return filterList.count
            
            
            
        }
        
        return 0
        
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        if collectionView == bottomCollectionView {
            
            
            
            
            
            
            
            let width =  collectionView.frame.width
            
            let height = collectionView.frame.height
            
            
            
            return CGSize(width: width, height: height - 5)
            
            
            
        }
            
        else {
            
            
            
            let width =  collectionView.frame.width / 4-1
            
            let height = collectionView.frame.height
            
            
            
            return CGSize(width: width, height: height)
            
            
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        
        
        if collectionView == bottomCollectionView {
            
            return 0.0
            
            
            
        }
            
        else {
            
            return 15.0
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        
        
        if collectionView == bottomCollectionView {
            
            return 0.0
            
        }
            
        else {
            
            return 1.0
            
        }
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if (collectionView == bottomCollectionView){
            
            
            
            print("YESSSS \(indexPath.row)")
            
            //[String : String]
            
            
            
            let lat1 : Double =  Double.init("\(feedMapSearch[indexPath.row].latitude)")!
            
            let lon1 : Double =  Double.init("\(feedMapSearch[indexPath.row].longitude)")!
            
            
            
            let location = CLLocationCoordinate2DMake(lat1, lon1)
            
            
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
         let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            
            
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            map.setRegion(region, animated: true)
            
            
            
            
            
            let starbucksAnnotation = feedMapSearch[indexPath.row]
            let popOverVC = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "popUpCardMapViewController") as! popUpCardMapViewController
            self.addChildViewController(popOverVC)
            popOverVC.starbucksAnnotation = starbucksAnnotation
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
            
            
           }
        
        if (collectionView == topCollectionView) {
            
            if let cell = collectionView.cellForItem(at: indexPath)
                
            {
                
                let s = cell  as! TopCollectionViewCell
                
          
               
                if (s.i == 1){
                   // Deselect
                    s.rounded.backgroundColor = UIColor.white
                    
                    s.text.textColor = UIColor.black
                    s.i = 0
                    
                    var strTab : [String] = []
                    for k in selectedStringCategoryFeed{
                        if (k.trimmingCharacters(in: .whitespacesAndNewlines) != filterList[indexPath.row].trimmingCharacters(in: .whitespacesAndNewlines)){
                            strTab.append(k)
                        }
                    }
                    self.selectedStringCategoryFeed = strTab
                    
                    /******* Check If All cell deselected ********/
                    
                    var testB : Bool = false
                    
                    if  (strTab.count == 0){
                        arrounded.backgroundColor = UIColor.init(hexString: "009EFA")
                        txtRounded.textColor = UIColor.white
                    }
                    
                    /*********************************************/
                    
                }else {
                    // Select
                    selectedStringCategoryFeed.append(filterList[indexPath.row])
                    //SelectedButton ALL
                    arrounded.backgroundColor = UIColor.white
                    txtRounded.textColor = UIColor.black
                    
                    s.i = s.i + 1
                    s.rounded.backgroundColor = UIColor.init(hexString: "009EFA")
                    s.text.textColor = UIColor.white
                    
                }
                
                
                
                
                
                /***********************  Filter Data by Catagory ***************/
                
                
                self.feedMapSearch = []
                
                self.bottomCollectionView.reloadData()
                
                if ( selectedStringCategoryFeed.count == 0 ){
                     for k in self.feedMap {
                         self.feedMapSearch.append(k)
                    }
                } else {
                    for k in self.feedMap {
                        
                        //addAllFiltredAnnotation
                        
                        for p in selectedStringCategoryFeed {
                            
                            if (k.categories.contains(p)){
                                
                                self.feedMapSearch.append(k)
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }
                
               
                self.bottomCollectionView.reloadData()
                
                
                
                removeAllAnnotations()
                
                
                
                addAllFiltredAnnotation()
                 /****************************************************************/
                
            }
        }
        
    }
    
    
    
    
    func didDeselectItemAtCustom( collectionView: UICollectionView ,  indexPath : IndexPath){
        if (self.topCollectionView == collectionView ){
            print("didDeselectItemAtCustom ENTER")

            if let cell = collectionView.cellForItem(at: indexPath)
            {
                print("didDeselectItemAtCustom ENTER YES")
                let s = cell  as! TopCollectionViewCell
                
                s.rounded.backgroundColor = UIColor.white
                
                s.text.textColor = UIColor.black
            }
            print("didDeselectItemAtCustom ENTER END")
        }
        
     }
    
    
    
    
    
    
    
    
    
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    
    
    
    
/******************************************** UPDATE ***********************************************/
    
    
    //MARK: MKMapViewDelegate
 func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation
        {//currentlocation
            var annotationView = self.map.dequeueReusableAnnotationView(withIdentifier: "Pin")
            annotationView?.image = UIImage(named: "currentlocation")

           // starbucksAnnotation.image
            return annotationView
        }
    
        return nil
    }
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            
        } else {
            if (view.annotation as? StarbucksAnnotation != nil){
                let starbucksAnnotation = view.annotation as! StarbucksAnnotation
                let popOverVC = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "popUpCardMapViewController") as! popUpCardMapViewController
                self.addChildViewController(popOverVC)
                popOverVC.starbucksAnnotation = starbucksAnnotation
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParentViewController: self)
                /************** End Check your network *************/
                self.map.deselectAnnotation(starbucksAnnotation, animated: true)
            }
          
        }
        
        // 2
       /* let starbucksAnnotation = view.annotation as! StarbucksAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        
        calloutView.name.text = starbucksAnnotation.name
        calloutView.strPhone = starbucksAnnotation.phone
        calloutView.obj = starbucksAnnotation
        //
        let button = UIButton(frame: calloutView.callBtn.frame)
        button.addTarget(self, action: #selector(MapViewController.callPhoneNumber(sender:)), for: .touchUpInside)
        calloutView.addSubview(button)
        
        
        //GoToVenusClientAction
        
        let button2 = UIButton(frame: calloutView.orderBTN.frame)
        button2.addTarget(self, action: #selector(MapViewController.GoToVenusClientAction(sender:)), for: .touchUpInside)
        calloutView.addSubview(button2)
        
      //  calloutView.starbucksImage.image = starbucksAnnotation.image
        // 3
        
        
        if let url = URL.init(string: starbucksAnnotation.image) {
            
            calloutView.picture.downloadedFrom(url: url)
            
        }
        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)*/
        /************** POP UP **********/
        /*************** Check your Network **************/
    
    }
    


 

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
 
    
    
    
    
    
    
    
    func findFeedByLagLat(lat : String , lon : String , token : String ){
        
        
        
        let params  =   ["latitude": "\(lat)" , "longitude" :"\(lon)"  ]
        
        let headers = ["Authorization":"Bearer \(token)"]
        
        
        
        self.feedMap = []
        
        self.feedMapSearch = []
        
        //self.tableView.reloadData()
        
        print("params , \(params)")
        
        print("headers , \(headers)")
        
        print("Urls.CATAGORY_LIST = \(Urls.MAP)")
        
        AFWrapper.requestPOSTURL(Urls.MAP, params: params as [String : String] , headers: headers, success: { (resJSON) in
            
            print("************************** Result ****************************")
            print(resJSON)
            print("**********END************* Result ****************************")

            
            var i : Int = 0
            for k in resJSON.array! {
                
                let lat0 : Double =  Double.init( k ["latitude"].string!)!
                
                let lon0 : Double =  Double.init(k ["longitude"].string!)!
                
                
                let point = StarbucksAnnotation(coordinate: CLLocationCoordinate2D(latitude: lat0 , longitude: lon0 ))
                
                
                
                point.address = k ["address"].string!
                
                for i in  k["categories"].array!{
                    
                    let s = "\(i)"
                    
                    point.categories.append(s.trimmingCharacters(in: .whitespacesAndNewlines))
                    
                }
                
                point.image = k ["image"].string!
                
                point.lastname = k ["lastname"].string!
                
                point.latitude = k ["latitude"].string!
                
                point.longitude = k ["longitude"].string!
                
                point.name = k ["name"].string!
                
                point.phone = k ["phone"].string!
                
                point.physical_address = k ["physical_address"].string!
                
                point.purchases = k ["purchases"].string!
                
                point.times = k ["times"].string!
                
                point.website = k ["website"].string!
                
                self.feedMap.append(point)
                
                self.feedMapSearch.append(point)
                
                
                self.map.addAnnotation(point)
                // 3
              
                
                
                
                
                
                
                
                
                
                
            }
            
            
            
            self.bottomCollectionView.reloadData()
            
            
            
            print("*********** PERFECT *********")
            
            print(self.feedMap.count)
            
 
            
            
            
        }) { (errorJSON) in
            
            
            
            print(errorJSON)
            
            self.feedMap = []
            
            self.feedMapSearch = []
            
            self.removeAllAnnotations()
            
            self.bottomCollectionView.reloadData()
            
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        
        
        // var childViews : [MKAnnotationView] = views
        
        //      childViews.removeFirst()
        
        
        
        /*for childView:MKAnnotationView in views{
         
         if childView.annotation!.isKind(of: MKUserLocation.self){
         
         childView.canShowCallout = false
         
         }
         
         }*/
        
        
        
        
        
    }
    
    
    
    
    
    func removeAllAnnotations() {
        
        for annotation in self.map.annotations {
            
            self.map.removeAnnotation(annotation)
            
        }
        
    }
    
    
    //addAllFiltredAnnotation
    
    func addAllFiltredAnnotation(){
        for obj in self.feedMapSearch {
            /************* Add PIN To MAPS **************/
            
            self.map.addAnnotation(obj)
            
        }
    }
    
    
    
    
    /*func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
        
        
        if (collectionView == self.bottomCollectionView){
            
            print("****************************** forItemAt  targetIndexPathForMoveFromItemAt : indexPath   \(indexPath.row) ")
            
           var i : Int = 0
            
            
            
            if (self.feedMapSearch.count  != 0 ){
                
                i = indexPath.row
                
                
                
              //  self.bottomCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
                
                let lat1 : Double =  Double.init("\(feedMapSearch[i].latitude)")!
                
                let lon1 : Double =  Double.init("\(feedMapSearch[i].longitude)")!
                
                
                
                let location = CLLocationCoordinate2DMake(lat1, lon1)
                
                
                
                let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
                
 
                let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                
                
                
                let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
                 map.setRegion(region, animated: true)
                
            }
       
        }
        
        
        
    }*/
    

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //(cv.isDragging || cv.isDecelerating);
        if (self.bottomCollectionView == scrollView ){
            let x = scrollView.contentOffset.x
            let w = scrollView.bounds.size.width
            let currentPage = Int(ceil(x/w))
            // Do whatever with currentPage.
            print(currentPage)
            
            
            var i : Int = 0
            
            
            
            if (self.feedMapSearch.count  != 0 ){
                
                
                
                
                //  self.bottomCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
                
                let lat1 : Double =  Double.init("\(feedMapSearch[currentPage].latitude)")!
                
                let lon1 : Double =  Double.init("\(feedMapSearch[currentPage].longitude)")!
                
                
                
                let location = CLLocationCoordinate2DMake(lat1, lon1)
                
                
                
                let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
                
                
                let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                
                
                
                let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
                map.setRegion(region, animated: true)
                
            }
            
            
        }
       
     //   self.bottomCollectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
        
    }
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
   gradient = CAGradientLayer()
        
        gradient.frame = topCollectionView.bounds
        
        gradient.startPoint = CGPoint(x: 0,y:0.5)
        gradient.endPoint = CGPoint(x: 0.2 ,y: 0.5)
        
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor ]
        // gradient.locations = [0, 0.4 , 0.6, 1]
        topCollectionView.layer.mask = gradient
        // testtest
        
 
    }
    
    
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}






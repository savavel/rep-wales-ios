//
//  OptionsTableViewCell.swift
//  rep
//
//  Created by bechir Kaddech on 9/3/17.
//  Copyright © 2017 wales. All rights reserved.
//

import UIKit

class OptionsTableViewCell: UITableViewCell , UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var youCanScroll: UIImageView!
    
    var didgo : Bool = false
    
    
    var PickerNameList = [String]()
    var PickerNumberList = [String]()
    var listOf = [IndexPath]()
    
    var max : Int?
    var min : Int?
    
    
    var currentSlected : Int = 0
    var lastSelectedIndex : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.allowsMultipleSelection = true
        self.collectionView.flashScrollIndicators()
        
        
    
       
    }
    




    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (collectionView == scrollView){
            self.youCanScroll.isHidden = true
        }
    }
    
    func fillCollectionViewNames(with PickerNameList : [String]) {
        self.PickerNameList = PickerNameList
        self.collectionView.reloadData()
        
        print("\(self.collectionView.indexPathsForVisibleItems.count) == \(PickerNameList.count)")
        
        if (  2 == PickerNameList.count ){
            self.youCanScroll.isHidden = true
        }
    }
    
    func fillCollectionViewNumber(with PickerNumberList : [String]) {
        self.PickerNumberList = PickerNumberList
        self.collectionView.reloadData()
    }
    
    func setMax(with max : String) {
        self.max = Int(max)
      
    
        
    }
    
    func setMin(with min : String) {
        self.min = Int(min)
        
        if( self.min == 1 ) {
            print("our min is 1")
            
            let indexPath = IndexPath(row: 0, section: 0)
            self.collectionView(collectionView, didSelectItemAt: indexPath)
          

            
          
         
        }
       
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       

        // Configure the view for the selected state
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PickerNameList.count
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickerCell", for: indexPath) as! PickerCollectionViewCell
        
        
        cell.pickerText.text =  PickerNameList[indexPath.row]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        
        if let cell = collectionView.cellForItem(at: indexPath) as? PickerCollectionViewCell {
            // it worked
            let selectedItems = collectionView.indexPathsForSelectedItems
      
            
            if currentSlected == max {
                
                print("selected when max")
                collectionView.deselectItem(at: indexPath, animated: true)
                
            }else {
                
                cell.pickerText.backgroundColor = UIColor.white
                cell.pickerText.textColor = UIColor.black
                cell.pickerText.layer.cornerRadius = 5
                cell.pickerText.layer.masksToBounds = true
                print("before select")
                print(currentSlected)
                currentSlected = currentSlected + 1
                
                print("after select")
                print(currentSlected)
                listOf.append(indexPath)
                
                let imageDataDict:[String: String] = ["price": PickerNumberList[indexPath.row],"name" : PickerNameList[indexPath.row] ]
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updatePrice"), object: nil, userInfo: imageDataDict)
            }
            
        }
        else {
            // it didn't work
            
            print("it didn't work")
        }
        
        
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if  let cell  = collectionView.cellForItem(at: indexPath) as? PickerCollectionViewCell {
        
        
        if  listOf.contains(indexPath) {
            cell.pickerText.backgroundColor = UIColor.clear
            cell.pickerText.textColor = UIColor.white
            
            print("before deselect")
            print(currentSlected)
            currentSlected = currentSlected - 1
            
            print("after deselect")
            print(currentSlected)
            if let index = listOf.index(of: indexPath) {
                listOf.remove(at: index)
            }
            
            let imageDataDict:[String: String] = ["price": PickerNumberList[indexPath.row],"name" : PickerNameList[indexPath.row] ]
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reducePrice"), object: nil, userInfo: imageDataDict)
            
            
            
        }
        else {
            
            print("else of deselect")
            
        }
        
        }
        
        
        
        
        
    }
    
    
    
    
    
}
    

    
    
    
    


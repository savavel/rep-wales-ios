//
//  Urls.swift
//  rep
//
//  Created by bechir Kaddech on 8/30/17.
//  Copyright © 2017 wales. All rights reserved.
//

import Foundation



class Urls : NSObject  {
    
    
    static let ipAddress : String = "api.lynq.eu"
    static let USER_SIGNIN : String = "https://" + ipAddress + "/api/user"
    static let USER_SIGNUP : String = "https://" + ipAddress + "/api/users"
    static let GAMES_LIST : String = "https://" + ipAddress + "/api/v1/games"
    static let CATAGORY_LIST : String =  "https://" + ipAddress + "/api/wallet/category"
    static let CLIENTS_LIST : String =  "https://" + ipAddress + "/api/clients"
    static let USER_INFO : String = "https://" + ipAddress + "/api/user_info"
    static let WALLET : String = "https://" + ipAddress + "/api/user_wallet"
    static let SAVE_CARD : String = "https://" + ipAddress + "/api/save_card"
    static let DELETE_CARD : String = "https://" + ipAddress + "/api/delete_card"

    static let MAP : String = "https://" + ipAddress + "/api/clients/map"
    static let PURCHASE : String = "https://" + ipAddress + "/api/purchase"
    static let MASKED_CARD : String = "https://"+ipAddress+"/api/get_masked_card"
    static let UPDATE_PASSWORD : String = "https://"+ipAddress+"/api/change_password"
    static let TABLE_ORDER : String = "https://"+ipAddress+"/api/table_order"
    static let DEVICE_TOKEN : String = "https://"+ipAddress+"/api/save_device_token"
    static let WALLET_HISTORY : String = "https://"+ipAddress+"/api/wallet_history"

    
}

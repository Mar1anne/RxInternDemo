//
//  UIImage+HelperMethods.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/5/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

extension UIImage {
    func toBase64() -> Data? {
        guard let data = UIImagePNGRepresentation(self) else { return nil }
        return data.base64EncodedData(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}

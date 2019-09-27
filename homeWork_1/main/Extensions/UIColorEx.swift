//
//  UIColorEx.swift
//  homeWork_1
//
//  Created by Марат Нургалиев on 27/09/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

extension UIColor {
	struct vkColor {
		static let main = UIColor.init(red: 65/255, green: 107/255, blue: 158/255, alpha: 1)
	}
	
	struct indicator {
		static let background = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
	}
	
	struct squareIndicator {
		static let background = UIColor(red: 24/255, green: 139/255, blue: 243/255, alpha: 1)
		static let strokeColor = UIColor(red: 238/255, green: 243/255, blue: 251/255, alpha: 1)
		static let fillColor = UIColor(red: 92/255, green: 175/255, blue: 248/255, alpha: 1)
	}
}

//
//  ViewController.swift
//  KituraClient
//
//  Created by modelf on 4/21/17.
//  Copyright © 2017 ChristopherMoore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var helloKituraLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		downloadAPIData() { data, bool in
			if bool {
				DispatchQueue.main.async(execute: {
					self.helloKituraLabel.text = data
				})
			}
		}
	}
	
	
	func downloadAPIData(callback: @escaping (_ result: String?, _ complete: Bool) -> Void) {
		
		let url = URL(string: "https://pure-ridge-71295.herokuapp.com/HelloWorld")
		let request = URLRequest(url: url!)
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			if let response = response {
				print("\(response.description)")
			}
			
			if let error = error {
				print("\(error.localizedDescription)")
			}
			
			guard let data = data else {
				print("data is not data")
				callback(nil, false)
				return
			}
			
			let stringLabel = String(data: data, encoding: .utf8)
			print(stringLabel)
			
			callback(stringLabel, true)
			
			
		}
		.resume()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}


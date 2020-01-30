//
//  PlanetDetailViewController.swift
//  Planets
//
//  Created by Andrew R Madsen on 9/20/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var planet: Planet? {
        didSet {
            updateViews()
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Private
    private func updateViews() {
        guard let planet = planet, isViewLoaded else {
            imageView?.image = nil
            label?.text = nil
            return
        }
        
        imageView.image = planet.image
        label.text = planet.name
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - State Restoration
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        guard let planet = planet else { return }
        let planetData = try? PropertyListEncoder().encode(planet)
        coder.encode(planetData, forKey: "planetDataKey")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        guard let planetData = coder.decodeObject(forKey: "planetDataKey") as? Data else { return }
        planet = try? PropertyListDecoder().decode(Planet.self, from: planetData)
    }
}

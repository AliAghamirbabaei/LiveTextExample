//
//  ViewController.swift
//  LiveTextExample16
//
//  Created by Ali Aghamirbabaei on 6/11/22.
//

import UIKit
import VisionKit

class ViewController: UIViewController, ImageAnalysisInteractionDelegate, UIGestureRecognizerDelegate {
    let image = UIImage(named: "Image")
    let imageView = UIImageView()
    let analyzer = ImageAnalyzer()
    let interaction = ImageAnalysisInteraction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
                
        // This should call when user wants to use live text for another image
        // interaction.preferredInteractionTypes = []
        // interaction.analysis = nil
    }
    
    private func setupUI() {
        imageView.image = image
        view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewTopAnchor = imageView.topAnchor.constraint(equalTo: view.topAnchor)
        let imageViewBottomAnchor = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let imageViewTrailingAnchor = imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let imageViewLeadingAnchor = imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        view.addConstraints([imageViewTopAnchor, imageViewBottomAnchor, imageViewTrailingAnchor, imageViewLeadingAnchor])
        
        //
        imageView.addInteraction(interaction)
        analyzeCurrentImage()
    }
    
    private func analyzeCurrentImage() {
        if let image = image {
            Task {
                let configuration = ImageAnalyzer.Configuration([.text, .machineReadableCode])
                do {
                    let analysis = try await analyzer.analyze(image, configuration: configuration)
                    if let analysis = analysis, image == self.image {
                        interaction.analysis = analysis;
                        interaction.preferredInteractionTypes = .automatic
                    }
                }
                catch {
                    // Handle error…
                }
            }
        }
    }
    
}


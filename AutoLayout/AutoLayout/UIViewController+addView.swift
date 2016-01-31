//
//  UIViewController+addView.swift
//  AutoLayout
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2016 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import UIKit

/**
 A UIViewController extension for adding views to a view controller
 */

extension UIViewController {
  
  /**
   A convenience method to create a UIImageView and then
   add it to the view controller view. The UIImageView is
   created from a UIImage using the name parameter.
   
   - Note: The translatesAutoresizingMaskIntoConstraints 
   flag is set to false for the UIImageView. Make sure you
   add sufficient constraint to fix the position.
   
   - Parameter name: A String which should match the name
   of a valid image file in the application bundle or asset
   catalog.
   
   - Returns: The newly created UIImageView or nil.
   */
  
  func addImageViewForImageNamed(name: String) -> UIImageView? {
    if let image = UIImage(named: name) {
      let imageView = UIImageView(image: image)
      imageView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(imageView)
      return imageView
    }
    return nil
  }
}


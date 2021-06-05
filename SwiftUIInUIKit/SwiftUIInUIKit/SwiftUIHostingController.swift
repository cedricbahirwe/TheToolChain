//
//  SwiftUIHostingController.swift
//  SwiftUIInUIKit
//
//  Created by Cédric Bahirwe on 14/03/2021.
//

import UIKit
import SwiftUI

struct SecondView: View {
  var body: some View {
      VStack {
          Text("Second View").font(.system(size: 36))
          Text("Loaded by SecondView").font(.system(size: 14))
      }
  }
}

class SwiftUIHostingController: UIHostingController<SecondView> {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SecondView())
    }

}

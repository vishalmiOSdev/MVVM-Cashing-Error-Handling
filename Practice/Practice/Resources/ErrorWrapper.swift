//
//  ErrorWrapper.swift
//  Practice
//
//  Created by Vishal Manhas on 29/11/24.
//

import SwiftUI

struct ErrorWrapper: View {
    var title:String
    var discription:String
    var actionTitle:String?
    var action:(()->())?
    
    
    var body: some View {
        VStack{
        
            Text(title)
                .fontWeight(.bold)
            Text(discription)
                .fontWeight(.medium)
            Button(action: {
                action?()
            }, label: {
                Text(actionTitle ?? "")
                    .foregroundStyle(Color.red)
            })
            
        }
    }
}

#Preview {
    ErrorWrapper(title: "Bad Response", discription: "Please try after some time", actionTitle: "Retry",action: {
        print("Fetch Data Again")
    })
}

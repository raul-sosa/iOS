//
//  CircularImage.swift
//  Paisajes
//
//  Created by Alumno 17 on 10/09/25.
//

import SwiftUI

struct CircularImage: View {
    
    var image: Image
    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

/*struct CircularImage_Previews: PreviewProvider {
    static var previews: some View {
        CircularImage(image: Image(systemName: "photo"))
    }
}*/

#Preview {
    CircularImage(image: Image("fdi"))
}

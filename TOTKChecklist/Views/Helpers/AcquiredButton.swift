import SwiftUI

struct AcquiredButton: View {
  @Binding var isSet: Bool
  
  var body: some View {
    Button {
      isSet.toggle()
    } label: {
      Label("Acquired", systemImage: isSet ? "checkmark.circle.fill" : "checkmark.circle")
        .foregroundColor(isSet ? .yellow : .gray)
    }.font(.subheadline)
  }
}

struct AcquiredButton_Previews: PreviewProvider {
    static var previews: some View {
      AcquiredButton(isSet: .constant(true))
    }
}

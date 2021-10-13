// SwiftUI Notes:
// ================================

// MARK: - Sharing SwiftUI state with @ObservedObject
// https://www.hackingwithswift.com/books/ios-swiftui/sharing-swiftui-state-with-observedobject

// For structs:
struct User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct ContentView: View {
    @State private var user = User()
    ...

// For classes:
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

// User property with @State is designed to track local structs 
// rather than external classes. 

class User {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
    @ObservedObject var user = User()

// I removed the private access control there, but whether or not you use it depends on your usage
// if you’re intending to share that object with other views then marking it as private will just cause confusion.

// The @ObservedObject property wrapper can only be used on types that conform to the ObservableObject protocol. 
// This protocol has no requirements, and really all it means is: 
// “we want other things to be able to monitor this for changes.”

// So, modify the User class to this:

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

// Rather than just using @State to declare local state, we now take three steps:

// - Make a class that conforms to the ObservableObject protocol.
// - Mark some properties with @Published so that any views using the class get updated when they change.
// - Create an instance of our class using the @ObservedObject property wrapper.

// The end result is that we can have our state stored in an external object, and, even better, 
// we can now use that object in multiple views and have them all point to the same values.

// ================================

// MARK: - Showing and hiding views
// https://www.hackingwithswift.com/books/ios-swiftui/showing-and-hiding-views

// MARK: - Storing user settings with UserDefaults
// https://www.hackingwithswift.com/books/ios-swiftui/storing-user-settings-with-userdefaults

// UserDefaults, it allows us to store small amount of user data directly attached to our app. 
// There is no specific number attached to “small”, but you should keep in mind that everything you store in UserDefaults 
// will automatically be loaded when your app launches – if you store a lot in there your app launch will slow down. 
// To give you at least an idea, you should aim to store no more than 512KB in there.

// Tip: If you’re thinking “512KB? How much is that?” then let me give you a rough estimate: 
// it’s about as much text as all the chapters you’ve read in this book so far.

// !!!
// However, there is a catch: it is stringly typed. This is a bit of a joke name, because “strongly typed” 
// means a type-safe language like Swift where each constant and variable has a specific type such as Int or String, 
// but “stringly typed” means some code that uses strings in places where they might cause problems.

// MARK: - Archiving Swift objects with Codable
// https://www.hackingwithswift.com/books/ios-swiftui/archiving-swift-objects-with-codable
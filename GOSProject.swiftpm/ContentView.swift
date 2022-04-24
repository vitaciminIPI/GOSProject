import SwiftUI

struct ContentView: View {
    
//    Fingers
    @State var roboFingers = [true, true, true]
    @State var myFingers = [true, true, true]
    
//    PopUp
    @State var popup = true
    
//    Hand
    @State var roboHand = "3fing2"
    @State var myHand = "3fing"
    
//    Win Lose
    @State var show = false
    @State var done = false
    @State var win = false
    @State var lose = false
    
//    Win Lose String
    @State var pWin = "YOU WIN!"
    @State var rWin = "ROBOT WIN!"
    @State var emoji1 = "😎"
    @State var emoji2 = "🤖"
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack (alignment: .trailing) {
                Image(roboHand)
                Spacer()
                
                Spacer()
                Image(myHand)
            }
            
            VStack {
                ThreeOption(handSign: $roboHand, roboFingers: $roboFingers, myHand: $myHand, myFingers: $myFingers, done: $done, win: $win, lose: $lose)
                
                
            }
            
            VStack (alignment: .trailing) {
                ModalPopUp()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            
            if done {
                if win {
                    WinnerPopUpView(textWin: $pWin, emoji: $emoji1, show: $show, roboFingers: $roboFingers, roboHand: $roboHand, myFingers: $myFingers, myHand: $myHand, done: $done, win: $win, lose: $lose)
                }
                else if lose {
                    WinnerPopUpView(textWin: $rWin, emoji: $emoji2, show: $show, roboFingers: $roboFingers, roboHand: $roboHand, myFingers: $myFingers, myHand: $myHand, done: $done, win: $win, lose: $lose)
                }
                else {
                    DrawPopUpView(show: $show, roboFingers: $roboFingers, roboHand: $roboHand, myFingers: $myFingers, myHand: $myHand, done: $done, win: $win, lose: $lose)
                }
            }
            
            VStack {
                if popup {
                    Intros(popup: $popup)
                }
            }
            
        }
    }

}

// Reset
func reset(myFingers: inout [Bool], myHand: inout String, roboFingers: inout [Bool], roboHand: inout String, done: inout Bool, win: inout Bool, lose: inout Bool) {
    myFingers = [true, true, true]
    roboFingers = [true, true, true]
    myHand = "3fing"
    roboHand = "3fing2"
    done = false
    win = false
    lose = false
}

// Check Winner
func checkWinner(myFingers: inout [Bool], roboFingers: inout [Bool], win: inout Bool, lose: inout Bool) {
    
    if myFingers[0] {
        if roboFingers[1] {
            playSfx(key: "win")
            win = true
        }
        else if roboFingers[2]{
            playSfx(key: "lose")
            lose = true
        }
        else {
            playSfx(key: "draw")
        }
    }
    else if myFingers[1] {
        if roboFingers[0] {
            playSfx(key: "lose")
            lose = true
        }
        else if roboFingers[2] {
            playSfx(key: "win")
            win = true
        }
        else {
            playSfx(key: "draw")
        }
    }
    else {
        if roboFingers[0] {
            playSfx(key: "win")
            win = true
        }
        else if roboFingers[1] {
            playSfx(key: "lose")
            lose = true
        }
        else {
            playSfx(key: "draw")
        }
    }

}

// firstMove Robot
func robotFirstMove(myFingers: inout [Bool], myHand: inout String) {
        let idx = Int.random(in: 0 ..< 3)
        myFingers[idx] = false
//        print("aaa \(idx)")
        if idx == 0 {
            myHand = "rock"
        }
        else if idx == 1 {
            myHand = "call"
        }
        else {
            myHand = "l-sign"
        }
}

// secondMove Robot
func robotSecondMove(myFingers: inout [Bool], myHand: inout String) {
//    var idx = 0
//    print(idx)
    while true {
        let idx2 = Int.random(in: 0 ..< 3)
        if (myFingers[idx2] != false) {
            myFingers[idx2] = false
//            idx = idx2
            break
        }
    }
//    print("bbb \(idx)")
    if myFingers[0] {
        myHand = "Gajah"
    }
    else if myFingers[1] {
        myHand = "Orang"
    }
    else {
        myHand = "Semut"
    }

}

// ThreeOption button
struct ThreeOption: View {
    
//    Bind Var
    @Binding var handSign: String
    @Binding var roboFingers: [Bool]
    @Binding var myHand: String
    @Binding var myFingers: [Bool]
    @Binding var done: Bool
    @Binding var win: Bool
    @Binding var lose: Bool
    
//    State Var
    @State var isPressed = [false, false, false]
    @State var count = 0
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 750)
            HStack (spacing: 10) {
                
                if !isPressed[0] {
                    Button("Gajah 🐘") {
                        
                        playSfx(key: "click")
                        
                        isPressed[0] = true
                        
                        roboFingers[0] = false
                        
                        if count == 0 {
                            handSign = "rock2"
                            
                            robotFirstMove(myFingers: &myFingers, myHand: &myHand)
                            
                            count += 1
                        }
                        else if count == 1 {
                            if roboFingers[1] {
                                handSign = "Orang2"
                            }
                            else {
                                handSign = "Semut2"
                            }
                            
                            robotSecondMove(myFingers: &myFingers, myHand: &myHand)
                            
                            done = true
                            count = 0
                            
                            checkWinner(myFingers: &myFingers, roboFingers: &roboFingers, win: &win, lose: &lose)
                            
                            isPressed = [false, false, false]
                        }
                    }
                    .padding(.all, 20)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 32, weight: .bold))
                    .background(Color.white)
                    .cornerRadius(10)
                    .disabled(done)
                }
                if !isPressed[1] {
                    Button("Orang 👱‍♂️") {
                        
                        playSfx(key: "click")
                        
                        isPressed[1] = true
                        
                        roboFingers[1] = false
                        
                        if count == 0 {
                            handSign = "call2"
                            
                            robotFirstMove(myFingers: &myFingers, myHand: &myHand)
                            
                            count += 1
                        }
                        else if count == 1{
                            if roboFingers[0] {
                                handSign = "Gajah2"
                            }
                            else {
                                handSign = "Semut2"
                            }
                            
                            robotSecondMove(myFingers: &myFingers, myHand: &myHand)
        
                            done = true
                            count = 0
                            
                            checkWinner(myFingers: &myFingers, roboFingers: &roboFingers, win: &win, lose: &lose)
                            
                            isPressed = [false, false, false]
                        }
                    }
                    .padding(.all, 20)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 32, weight: .bold))
                    .background(Color.white)
                    .cornerRadius(10)
                    .disabled(done)
                }
                if !isPressed[2] {
                    Button("Semut 🐜") {
                        
                        playSfx(key: "click")
                        
                        isPressed[2] = true
                        
                        roboFingers[2] = false
                        
                        if count == 0 {
                            handSign = "l-sign2"
                            
                            robotFirstMove(myFingers: &myFingers, myHand: &myHand)
                            
                            count += 1
                        }
                        else if count == 1{
                            if roboFingers[0] {
                                handSign = "Gajah2"
                            }
                            else {
                                handSign = "Orang2"
                            }
                            
                            robotSecondMove(myFingers: &myFingers, myHand: &myHand)
                            
                            done = true
                            count = 0
                            
                            checkWinner(myFingers: &myFingers, roboFingers: &roboFingers, win: &win, lose: &lose)
                            
                            isPressed = [false, false, false]
                        }
                    }
                    .padding(.all, 20)
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 32, weight: .bold))
                    .background(Color.white)
                    .cornerRadius(10)
                }
                
            }
        }
    }
}

// Lose PopUp View
struct DrawPopUpView: View {
    
//    Binding var
    @Binding var show: Bool
    @Binding var roboFingers: [Bool]
    @Binding var roboHand: String
    @Binding var myFingers: [Bool]
    @Binding var myHand: String
    @Binding var done: Bool
    @Binding var win: Bool
    @Binding var lose: Bool
    
    var body: some View {
        ZStack {
            blurView()
                .ignoresSafeArea(.all)
            ZStack {
                Color.gray
                
                VStack {
                    Spacer()
                    Text("ROUND DRAW!")
                        .font(Font.system(size: 50, weight: .bold))
                        .foregroundColor(Color.white)

                    Text("😎 🤝 🤖")
                        .font(Font.system(size: 70))
                        .padding(.vertical, 10)
                    Spacer()
                    Button(action: {
                        playSfx(key: "click")
                        
                        show = false
                        
                        reset(myFingers: &myFingers, myHand: &myHand, roboFingers: &roboFingers, roboHand: &roboHand, done: &done, win: &win, lose: &lose)
                        
                    }) {
                        Image(systemName: "gobackward")
                            .resizable()
                            .frame(width:25, height: 30)
                    }
                    .padding(.horizontal, 100)
                    .padding(.vertical, 20)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    Spacer()
                }
                
            }.frame(width: 530, height: 380, alignment: .center)
                .cornerRadius(20)
        }
    }
}

// Winner PopUp View
struct WinnerPopUpView: View {
    
//    Binding Var
    @Binding var textWin: String
    @Binding var emoji: String
    @Binding var show: Bool
    @Binding var roboFingers: [Bool]
    @Binding var roboHand: String
    @Binding var myFingers: [Bool]
    @Binding var myHand: String
    @Binding var done: Bool
    @Binding var win: Bool
    @Binding var lose: Bool
    
    var body: some View {
        ZStack {
            blurView()
                .ignoresSafeArea(.all)
            ZStack {
                Color.green
                
                VStack {
                    Spacer()
                    Text(textWin)
                        .font(Font.system(size: 50, weight: .bold))
                        .foregroundColor(Color.white)

                    Text(emoji)
                        .font(Font.system(size: 70))
                        .padding(.vertical, 10)
                    Spacer()
                    Button(action: {
                        playSfx(key:    "click")
                        
                        show = false
                        
                        reset(myFingers: &myFingers, myHand: &myHand, roboFingers: &roboFingers, roboHand: &roboHand, done: &done, win: &win, lose: &lose)
                        
                    }) {
                        Image(systemName: "gobackward")
                            .resizable()
                            .frame(width:25, height: 30)
                    }
                    .padding(.horizontal, 100)
                    .padding(.vertical, 20)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    Spacer()
                }
                
            }.frame(width: 530, height: 380, alignment: .center)
                .cornerRadius(20)
        }
    }
}

// Help PopUp View
struct ModalPopUp: View {
    
    @State var popupText : Bool = false
    
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            
            VStack (alignment: .trailing) {
                
                Button(action: {
                    
                    withAnimation{
                        playSfx(key: "click")
                        popupText.toggle()
                    }
                    
                }) {
                    Image(systemName: "questionmark.circle")
                }.font(.largeTitle)
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(10)
                    .clipShape(Circle())
            }
            
            if popupText {
                ModalViews(show: $popupText)
            }
        }
        
    }
}

// Help PopUp Content
struct ModalViews: View {
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            blurView()
                .ignoresSafeArea(.all)
            ZStack {
                Color.white
                
                VStack (spacing: 20){
                    Text("RULES")
                        .font(Font.system(size: 30, weight: .bold))
                    
                    VStack (alignment: .leading, spacing: 10) {

                        Text("1. Thumb is a Gajah")
                            .font(Font.system(size: 20))
                        Text("2. Forefinger is an Orang")
                            .font(Font.system(size: 20))
                        Text("3. Littlefinger is a Semut")
                            .font(Font.system(size: 20))
                        Text("4. Gajah can defeat Orang but can be defeated by Semut")
                            .font(Font.system(size: 20))
                        Text("5. Orang can defeat Semut but can be defeated by Gajah")
                            .font(Font.system(size: 20))
                    }.padding(.vertical, 40)
                   
                    Button(action: {
                        withAnimation {
                            playSfx(key: "click")
                            show.toggle()
                        }
                    }) {
                        Text("Okay, Got It !")
                            .font(Font.system(size: 20, weight: .bold))
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
            }.frame(width: 550, height: 450, alignment: .center)
                .cornerRadius(20)
        }
    }
}

// BlurView
struct blurView : UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

struct Intros: View {
    
    @Binding var popup: Bool
    
    var body: some View {
        ZStack {
            blurView()
                .ignoresSafeArea(.all)
            ZStack {
                Color.white
                
                VStack (spacing: 20){
                    Text("IntroDuction")
                        .font(Font.system(size: 30, weight: .bold))
                    
                    VStack (alignment: .leading, spacing: 10) {

                        Text("Elephant-Man-Ant is a traditional game from China. The thumb represents the elephant, the index finger represents the person and the little finger represents the ant. Elephants are afraid of ants because ants can get into elephants' ears, people are afraid of elephants because elephants can step on people and so are ants who are afraid of people.")
                            .font(Font.system(size: 20))
                            .padding(.horizontal, 50)
                    }.padding(.vertical, 40)
                   
                    Button(action: {
                        withAnimation {
                            playSfx(key: "click")
                            popup.toggle()
                        }
                    }) {
                        Text("Okay, Cool !")
                            .font(Font.system(size: 20, weight: .bold))
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
            }.frame(width: 650, height: 450, alignment: .center)
                .cornerRadius(20)
        }
    }
}

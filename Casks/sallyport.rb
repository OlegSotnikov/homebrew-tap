cask "sallyport" do
  version "0.8.14"
  sha256 "f8f1e2d52e6932b028d931517b1de56dc7cadadb4d236da980b881c6bc183baa"

  url "https://sallyport.dev/downloads/Sallyport-#{version}.dmg",
      verified: "sallyport.dev/downloads/"
  name "Sallyport"
  desc "Secure store for API keys and tokens used by AI agents"
  homepage "https://sallyport.dev/"

  # Sallyport ships its own signed Sparkle updater; let it drive updates and
  # track new versions from the same appcast.
  livecheck do
    url "https://sallyport.dev/downloads/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  # Secure-Enclave-only product: Apple Silicon, macOS 14+.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Sallyport.app"

  uninstall quit: "dev.sallyport.mac"

  zap trash: [
    "~/Library/Application Support/dev.sallyport.mac",
    "~/Library/Caches/dev.sallyport.mac",
    "~/Library/HTTPStorages/dev.sallyport.mac",
    "~/Library/Preferences/dev.sallyport.mac.plist",
    "~/Library/Saved Application State/dev.sallyport.mac.savedState",
  ]
end

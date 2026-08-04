# Homebrew cask для ply. ЭТО ШАБЛОН, И ОН НЕ ПУБЛИКУЕТСЯ.
#
# ┌───────────────────────────────────────────────────────────────────────┐
# │ НАСТОЯЩЕЙ ВЕРСИИ ЗДЕСЬ НЕТ НАМЕРЕННО.                                 │
# │                                                                       │
# │ До 04.08.2026 она стояла числом и обновлялась руками в том же         │
# │ коммите, что и метка. Выпуск `v0.1.2` на этом и встал: метку          │
# │ подняли, cask остался на `0.1.0`, `release.sh` отказался собирать.    │
# │ Копия версии — не защита, а ещё одно место, где о ней забывают.       │
# │                                                                       │
# │ Единственный источник — `version` в `[workspace.package]` корневого   │
# │ `Cargo.toml`. `release.sh` сверяет с ним метку и подставляет сюда     │
# │ и версию, и SHA-256 точного нотаризованного DMG. Заполнитель ниже     │
# │ не является допустимой версией: шаблон, попавший к пользователю по    │
# │ ошибке, обязан не установиться, а не установить непонятно что.        │
# └───────────────────────────────────────────────────────────────────────┘
#
# `livecheck` смотрит в **ту же** ленту, по которой обновляется само
# приложение. Две разные точки истины о текущей версии разъезжаются молча:
# cask предлагал бы одно, Sparkle другое, и на площадке оказались бы
# две версии одного продукта в зависимости от того, чем ставили.
cask "ply" do
  version "0.1.9"
  sha256 "7edae6629a1c267c24c8ae7c7ad12b8316c00f1553ff003c9381eb55e200ca5d"

  url "https://ply.network/downloads/ply-#{version}.dmg",
      verified: "ply.network/downloads/"
  name "ply"
  desc "Bonded UDP transport that hands out redundancy by message importance"
  homepage "https://ply.network/"

  livecheck do
    url "https://ply.network/downloads/appcast.xml"
    strategy :sparkle
  end

  # Приложение обновляет себя само подписанным Sparkle.
  auto_updates true
  depends_on macos: :sonoma

  app "ply.app"
  binary "#{appdir}/ply.app/Contents/Helpers/ply-client", target: "ply-client"

  uninstall launchctl: "com.appmaster.ply.client",
            quit:      "com.appmaster.ply",
            trash:     "~/Library/LaunchAgents/com.appmaster.ply.client.plist"

  # Встроенный daemon доступен и приложению, и как `ply-client` в Homebrew prefix.
  # Конфигурацией он владеет сам:
  # /usr/local/etc/ply здесь НЕ трогается. Снести конфигурацию площадки
  # вместе с оболочкой наблюдения — это потерять ключ регистрации и потолки
  # тарифицируемых путей за одну команду `brew uninstall --zap`.
  zap trash: [
    "~/Library/Application Support/com.appmaster.ply",
    "~/Library/Caches/com.appmaster.ply",
    "~/Library/HTTPStorages/com.appmaster.ply",
    "~/Library/Preferences/com.appmaster.ply.plist",
    "~/Library/Saved Application State/com.appmaster.ply.savedState",
  ]
end

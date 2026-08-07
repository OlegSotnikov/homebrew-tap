# Homebrew formula for jc-rs.
#
# This is a template. `release.yml` fills in the version and the four archive
# checksums after the binaries are built, then commits the result to the tap.
# Do not edit the generated copy in the tap -- edit this file.
class JcRs < Formula
  desc "Convert the output of command-line tools, file formats and strings to JSON"
  homepage "https://jc-rs.com"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "0955f2e59fde08a44ce170567bf81cbaed21be65d438a1b681f45426c9c5cc25"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "c9cbf13e3687384424ec0adf976c0951e1e7d6da5646f50016f135c459beeae3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "eaf56eadef994996617fdb803d88537ef73bf5be093ae9962fba1dc3f91e8462"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "90b190fb62983e5d62e477eb9fe82bf66b4a9f27976968c3244fdd5e3f4edd84"
    end
  end

  def install
    bin.install "jc-rs"
    bash_completion.install "completions/jc-rs.bash" => "jc-rs"
    zsh_completion.install "completions/_jc-rs"
    fish_completion.install "completions/jc-rs.fish"
    # The archive also ships a `jc` alias. It is deliberately not installed:
    # it would shadow the Python jc in PATH, and that is not this formula's
    # call to make. `ln -s "$(brew --prefix)/bin/jc-rs" /usr/local/bin/jc` if
    # you want it.
  end

  test do
    assert_match "jc-rs version", shell_output("#{bin}/jc-rs --version")
    output = pipe_output("#{bin}/jc-rs --ps", "USER PID\nroot 1\n")
    assert_match "\"pid\"", output
  end
end

# Homebrew formula for jc-rs.
#
# This is a template. `release.yml` fills in the version and the four archive
# checksums after the binaries are built, then commits the result to the tap.
# Do not edit the generated copy in the tap; edit this file.
class JcRs < Formula
  desc "Convert the output of command-line tools, file formats and strings to JSON"
  homepage "https://jc-rs.com"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.4.0/jc-rs-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "1ce36e0c093bc8af398cf545db9c8d98b8d17928722db13aae7a985083e94ff8"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.4.0/jc-rs-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "8b1e798dc6de707b63e64da7a9286ec4198b3a433083a92ff9af0b26b8f1b973"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.4.0/jc-rs-v0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b6214709eba78fec54495fbccbab5ff1d802ae162bc37c3533e64456239e306f"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.4.0/jc-rs-v0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e8a412fefa683a6595f33bd69f0e45e4fdfcbe98939fd7f2893045272df419e1"
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

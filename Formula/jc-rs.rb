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
      sha256 "df5cd144204808df6eb9fdbcd2a07cbbb8bf036eca2f7ee39169b36e4eac6b8a"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "bf4d539a960c9963af8b783de9773e75a52a1be19fcfc1044e2959eb3bb6b8a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7f97ffdc23842d465668aa36aa2e476e4b51ca5bfeae10ac5f159aec6608a041"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "df962a68d8b1a18bfbafb00bf9649ced44985776a2ef00e6511b1dfa9475f7d5"
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

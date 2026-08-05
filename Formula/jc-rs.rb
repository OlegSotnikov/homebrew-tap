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
      sha256 "7a8050427cd761570fe31c5f747a063727ecf2a747d7c47a3e210138ab34d684"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "247790cf5bc72c709e4ea61ebbc28e1f5a16c28d372ff0e5640be29d6a1ee48d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "46f07446043cc42978231509d3ddd687a71e843bb9dd61988233a1c8221e2639"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9f424ce5e4275cbfffc0f6e85bb6eeb0f1fd1bd960ae08f0ed15134b2ffa8799"
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

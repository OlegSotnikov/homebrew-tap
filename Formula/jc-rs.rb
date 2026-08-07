# Homebrew formula for jc-rs.
#
# This is a template. `release.yml` fills in the version and the four archive
# checksums after the binaries are built, then commits the result to the tap.
# Do not edit the generated copy in the tap; edit this file.
class JcRs < Formula
  desc "Convert the output of command-line tools, file formats and strings to JSON"
  homepage "https://jc-rs.com"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.3.1/jc-rs-v0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "cb452accd3f3c4790a146aae304ee83ec41e8019152e9a7aef766733c5cf2c36"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.3.1/jc-rs-v0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "991c91dd58d51180abefda190bd1ed14dadbc8bdd6ac4f3c7b9276939958ed93"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.3.1/jc-rs-v0.3.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b9d197c8a47cd712fa486c6bdb7c89fe7858c9c613d7681a7da14b32dce78303"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.3.1/jc-rs-v0.3.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2df601eef65023d1b2c3d41f8ca62a7674883c558cf494982f6a557776d8a4eb"
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

# Homebrew formula for jc-rs.
#
# This is a template. `release.yml` fills in the version and the four archive
# checksums after the binaries are built, then commits the result to the tap.
# Do not edit the generated copy in the tap; edit this file.
class JcRs < Formula
  desc "Convert the output of command-line tools, file formats and strings to JSON"
  homepage "https://jc-rs.com"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "b9c7e158352bac20d7918c39a6d6163a564d7db888dfae0baa9eef77d0fd6097"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "5acc036b13bc9bc43ead4fb0b0d1c879c19680c5a92003f03c28e15fbdae3c6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "28172df60cdfe54e2e294c6ab0274c53f56e8ded08e87e07b576488b7c2a9095"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c48a120ef2fb8d8eb8e68a837dd5e0548a284b4f56cd8444a27f85d7e2d55a11"
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

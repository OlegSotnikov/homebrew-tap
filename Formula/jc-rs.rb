# Homebrew formula for jc-rs.
#
# This is a template. `release.yml` fills in the version and the four archive
# checksums after the binaries are built, then commits the result to the tap.
# Do not edit the generated copy in the tap; edit this file.
class JcRs < Formula
  desc "Convert the output of command-line tools, file formats and strings to JSON"
  homepage "https://jc-rs.com"
  version "0.5.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.5.1/jc-rs-v0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "5a3697f66d2e322b1e1e0c40610c1607a22d7efed5a153ee407e82d6f168915e"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.5.1/jc-rs-v0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "20fbdcff04e22b3e410bd368178f919465cc6a8dc409c8fa365ffe375413e4b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.5.1/jc-rs-v0.5.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d4e77006879945744244d8d75150c75e044f33198f84f5afabc19df6da122e0c"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.5.1/jc-rs-v0.5.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7b864a20534d46b72f0e40cef73fe2b500f1908f0fbbba2de2469529b95dc195"
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

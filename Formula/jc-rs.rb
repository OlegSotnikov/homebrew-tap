# Homebrew formula for jc-rs.
#
# This is a template. `release.yml` fills in the version and the four archive
# checksums after the binaries are built, then commits the result to the tap.
# Do not edit the generated copy in the tap; edit this file.
class JcRs < Formula
  desc "Convert the output of command-line tools, file formats and strings to JSON"
  homepage "https://jc-rs.com"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.5.0/jc-rs-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "dfb0f83143f544d43d9b78660c0bc06ec8dd5581fbf75e5549168a846806b3a9"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.5.0/jc-rs-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "c610c6726c385020f37274eb4e35764ad675052219c70cb88399360038592cc7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.5.0/jc-rs-v0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7c63b8c1eb31c23f4d254789b6f53ba93daefcabbcafb3a611c36156bca951e5"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.5.0/jc-rs-v0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "42725eb6fcb90c7ad6f884cf17c81f1dd931ae6bd10f7624a31ee362b2057f04"
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

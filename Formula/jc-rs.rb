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
      sha256 "75e086c12f9d06e9b74baa2400aa61ef2a84cdaf877e8a066cf6e6d8d885c98f"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "ed8a83d1025530d28948dd1fedbee45481df60d01228d57239fe30e79c8f0077"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7b9c7463505b952658429c152fbaca10a3b80d9fd94398cef721f681e51a9966"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "013ba5fc20b9d85309168d910bb4253a471fd3ef125b17ae09873631d773a1e3"
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

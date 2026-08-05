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
      sha256 "f2a8fcbd7b9a9fdd6628c7ec520f7254c4d376d448cddf4cacc08a2ef0035d5c"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "9ad2367903db11057a19dad52482dd3f8afb5a873436c0505386cb98b38cc81a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4c6acdecb73a29722cbe13e65468056f2fb674dc8dc08bdf6c0fb91895c2463f"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.1.0/jc-rs-v0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "208c0a54e76e6c6c2632c67fcb18b412bc848e3c1192b28e347d091bba167e6c"
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

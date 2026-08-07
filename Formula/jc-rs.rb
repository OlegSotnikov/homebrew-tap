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
      sha256 "8c4043569ce0c7a5935cbbd86515bf043f0683013d42505f947c7f32d9a93df1"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.3.1/jc-rs-v0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "4e58c7ad63c321cbd2df681d9ab6999a6d764b447cbf9f95baeab833554eecb4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.3.1/jc-rs-v0.3.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6e74fb169e5344b3ffec48159b3c3c0938db46b6c4b6957fbd6f602ac08f47c1"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.3.1/jc-rs-v0.3.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6ab081408ad62c877ac632883c1e1fabbbfba6bf45c5a9447fc9be240eb1e6a9"
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

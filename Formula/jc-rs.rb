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
      sha256 "8e7fd4e7293ac3d963b35b508a438c58e365ad993c869fc2713c88cce4fc05a0"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "de0858e063c2d3621d430136676f25b159c5c6638b48b3771cfe94a9b6de0b3f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6800e81a136fd2901c73778540d3bf5de176301bf0d2769582adcf7e5528c093"
    end
    on_intel do
      url "https://github.com/OlegSotnikov/jc-rs/releases/download/v0.2.0/jc-rs-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4c85415c5820cffeea73f9efc6ebb2b926162a1a48080e4dba3473fd8e8665a8"
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

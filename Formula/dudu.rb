# Homebrew formula for dudu. The release workflow fills in VERSION and SHA256 and pushes
# the result to github.com/fontnelle/homebrew-tap (Formula/dudu.rb).
class Dudu < Formula
  desc "Back up and restore your dev setup: packages, runtimes, dotfiles, terminal"
  homepage "https://github.com/fontnelle/dudu"
  url "https://github.com/fontnelle/dudu/releases/download/v0.3.0/dudu-0.3.0.tar.gz"
  sha256 "4a66306682cbd4994e4d5da5fce92e8a83728bd538fc90c72168090bc5c479b5"
  license "MIT"

  def install
    libexec.install "dudu", "lib", "bin", "completions"
    bin.install_symlink libexec/"dudu"
    # Links, so dudu keeps its own completions/ (dudu completion reads them from there).
    zsh_completion.install_symlink libexec/"completions/_dudu"
    bash_completion.install_symlink libexec/"completions/dudu.bash" => "dudu"
  end

  def caveats
    <<~EOS
      To highlight dudu commands while you type (zsh, with zsh-syntax-highlighting
      or fast-syntax-highlighting), add to ~/.zshrc:
        source #{opt_libexec}/completions/dudu.zsh
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dudu --version")
    assert_match "Usage", shell_output("#{bin}/dudu --help")
  end
end

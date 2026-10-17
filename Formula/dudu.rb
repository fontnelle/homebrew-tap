# Homebrew formula for dudu. The release workflow fills in VERSION and SHA256 and pushes
# the result to github.com/fontnelle/homebrew-tap (Formula/dudu.rb).
class Dudu < Formula
  desc "Back up and restore your dev setup: packages, runtimes, dotfiles, terminal"
  homepage "https://github.com/fontnelle/dudu"
  url "https://github.com/fontnelle/dudu/releases/download/v0.2.2/dudu-0.2.2.tar.gz"
  sha256 "e360d3a65ff3594cdf99ee0ec0cf8c75032cf7554f148dbc9398f7532548b048"
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

# Homebrew formula for dudu. The release workflow fills in VERSION and SHA256 and pushes
# the result to github.com/fontnelle/homebrew-tap (Formula/dudu.rb).
class Dudu < Formula
  desc "Back up and restore your dev setup: packages, runtimes, dotfiles, terminal"
  homepage "https://github.com/fontnelle/dudu"
  url "https://github.com/fontnelle/dudu/releases/download/v0.5.3/dudu-0.5.3.tar.gz"
  sha256 "14f7770413cfbabbcfe1a0b3a025213addf2a221a42ea734354436264ebc3e53"
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

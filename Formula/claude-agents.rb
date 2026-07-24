class ClaudeAgents < Formula
  desc "Local multi-agent dev setup: AI code review, test guardian, and PR-lesson mining"
  homepage "https://github.com/dmkr/claude-dev-agents"
  url "https://github.com/dmkr/claude-dev-agents/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "f48e0df72b668912bda5ca273e97b195c2ff252eb373bb4359f7b74696de9544"
  license "MIT"

  depends_on "gh"
  depends_on "jq"
  depends_on :macos

  def install
    # Everything lands flat in libexec: the CLI resolves its data files and its
    # helper scripts relative to its own real path, so they must be siblings.
    libexec.install Dir["libexec/*"]
    libexec.install "CLAUDE.md", "com.user.mine-all-repos.plist", "claude-agents"
    bin.install_symlink libexec/"claude-agents"
  end

  def caveats
    <<~EOS
      Claude Code is required and is not available via Homebrew:
        curl -fsSL https://claude.ai/install.sh | bash

      Then complete the one-time machine setup:
        claude-agents setup

      And install hooks per repo:
        cd ~/code/some-repo && claude-agents install

      Check health any time with:
        claude-agents status

      Note: repo hooks are symlinked into this formula's libexec, so after
        brew update && brew upgrade claude-agents
      re-run 'claude-agents install' in each repo to re-point them.
    EOS
  end

  test do
    assert_match "claude-agents", shell_output("#{bin}/claude-agents --version")
    assert_match "Dependencies", shell_output("#{bin}/claude-agents doctor", 1)
  end
end

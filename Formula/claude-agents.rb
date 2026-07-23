class ClaudeAgents < Formula
  desc "Local multi-agent dev setup: AI code review, test guardian, and PR-lesson mining"
  homepage "https://github.com/dmkr/claude-dev-agents"
  url "https://github.com/dmkr/claude-dev-agents/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "f8a1af26d2c2e2b5e1e198b374c39605b7e704b3ad51873558fb8cb577d16731"
  license "MIT"

  depends_on "gh"
  depends_on "jq"
  depends_on :macos

  def install
    libexec.install Dir["libexec/*"]
    prefix.install "CLAUDE.md"
    prefix.install "com.user.mine-all-repos.plist"
    bin.install "claude-agents"
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
    EOS
  end

  test do
    assert_match "claude-agents", shell_output("#{bin}/claude-agents --version")
    assert_match "Dependencies", shell_output("#{bin}/claude-agents doctor", 1)
  end
end

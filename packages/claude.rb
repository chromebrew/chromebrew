require 'package'

class Claude < Package
  description 'Claude Code, Anthropic’s agentic coding tool that lives in your terminal'
  homepage 'https://claude.com/product/claude-code'
  version '2.1.285'
  license 'Claude/Anthropic Terms and Conditions'
  compatibility 'x86_64'
  # Run `curl https://downloads.claude.ai/claude-code-releases/latest` to get the latest release.
  source_url "https://downloads.claude.ai/claude-code-releases/#{version}/linux-x64/claude"
  source_sha256 '33dad1ec615a2e08cc78b494f05c110e49916de2c79d78ec8799ebf46b233d29'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'claude', "#{CREW_DEST_PREFIX}/bin/claude", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'claude -h' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.claude")
  end
end

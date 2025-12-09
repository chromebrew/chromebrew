require 'package'

class Claude < Package
  description 'Claude Code, Anthropic’s agentic coding tool that lives in your terminal'
  homepage 'https://claude.com/product/claude-code'
  version '2.0.61'
  license 'Claude/Antropic Terms and Conditions'
  compatibility 'x86_64'
  source_url "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/#{version}/linux-x64/claude"
  source_sha256 '5c5686e99180eb0bd0498564e1fa991aa05c4199a08222a15c1563626332e8fc'

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

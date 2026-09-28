require 'package'

class Chatgpt < Package
  description 'ChatGPT desktop app for Linux'
  homepage 'https://chatgpt.com/'
  version '26.924.22138'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://persistent.oaistatic.com/codex-app-prod/linux/deb/latest/chatgpt_amd64.deb'
  source_sha256 'ce3bb1aa82ccdfe3037ada2fd8d187796ea4a0d5ed031d0e4ec8adce8b7014e7'

  no_compile_needed
  no_shrink

  def self.build
    File.write 'chatgpt.sh', <<~EOF
      #!/bin/bash
      #{CREW_PREFIX}/share/chatgpt/codex-launcher --no-sandbox "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'usr/lib/chatgpt', "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'chatgpt.sh', "#{CREW_DEST_PREFIX}/bin/chatgpt", mode: 0o755
  end
end

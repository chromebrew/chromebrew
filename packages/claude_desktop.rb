require 'package'

class Claude_desktop < Package
  description "Claude Code, Anthropic's agentic coding tool for the desktop"
  homepage 'https://claude.com/product/claude-code'
  version '2.9939.4'
  license 'Claude/Anthropic Commercial Terms of Service'
  compatibility 'x86_64'
  min_glibc '2.28'
  # To display this url, the latest Debian package must be installed and then run 'apt download --print-uris claude-desktop'
  source_url 'https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/claude-desktop_2.9939.4_amd64.deb'
  source_sha256 '3cfddb23bf2911e05e27b4ed3856b8e795df94643b2c35b59deb317cf995bca0'

  no_compile_needed

  depends_on 'sommelier' => :logical

  def self.preflight
    # Need at least 1.2 gb of free disk space to install.
    MiscFunctions.check_free_disk_space(1288490188)
  end

  def self.build
    File.write 'claude-desktop.sh', <<~EOF
      #!/bin/bash
      #{CREW_PREFIX}/share/claude-desktop/claude-desktop --no-sandbox "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'share', CREW_DEST_PREFIX
    FileUtils.mv 'lib/claude-desktop', "#{CREW_DEST_PREFIX}/share"
    FileUtils.install 'claude-desktop.sh', "#{CREW_DEST_PREFIX}/bin/claude-desktop", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'claude-desktop' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.claude")
  end
end

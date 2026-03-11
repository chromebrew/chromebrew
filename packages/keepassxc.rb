require 'package'

class Keepassxc < Package
  description 'KeePass Cross-Platform Community Edition, the free, open source, light-weight and easy-to-use password manager.'
  homepage 'https://keepassxc.org/'
  version '2.7.12'
  license 'GPL-2 or GPL-3'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/keepassxreboot/keepassxc/releases/download/#{version}/KeePassXC-#{version}-x86_64.AppImage"
  source_sha256 '564fe8b751b9ef7aa057e4d3d0b2878db24eaa0f6b1c855c82e699ab0913ae49'

  no_compile_needed

  depends_on 'sommelier' => :logical

  def self.build
    File.write 'keepassxc.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/keepassxc
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/keepassxc"
    FileUtils.install 'keepassxc.sh', "#{CREW_DEST_PREFIX}/bin/keepassxc", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/keepassxc"
  end

  def self.postinstall
    ExitMessage.add "\nType 'keepassxc' to get started.\n"
  end
end

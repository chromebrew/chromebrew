require 'package'

class Keepassxc < Package
  description 'KeePass Cross-Platform Community Edition, the free, open source, light-weight and easy-to-use password manager.'
  homepage 'https://keepassxc.org/'
  version '2.7.8'
  license 'GPL-2 or GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/keepassxreboot/keepassxc/releases/download/2.7.8/KeePassXC-2.7.8-x86_64.AppImage'
  source_sha256 '101b4d28a4960f01cc4dd6ca6a937dc4be60f47ccadd84b729d51401b4d346dd'

  no_compile_needed

  depends_on 'sommelier'

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
    ExitMessage.add "\nType 'keepassxc' to get started.\n".lightblue
  end
end

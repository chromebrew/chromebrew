require 'package'

class Keepassxc < Package
  description 'KeePass Cross-Platform Community Edition, the free, open source, light-weight and easy-to-use password manager.'
  homepage 'https://keepassxc.org/'
  version '2.7.10'
  license 'GPL-2 or GPL-3'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/keepassxreboot/keepassxc/releases/download/#{version}/KeePassXC-#{version}-x86_64.AppImage"
  source_sha256 '3f8308a4d905d067367d541b4dccd5e80700798039046ffc388ede4f50887b36'

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
    ExitMessage.add "\nType 'keepassxc' to get started.\n"
  end
end

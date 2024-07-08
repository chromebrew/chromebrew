require 'package'

class Keepassxc < Package
  description 'KeePass Cross-Platform Community Edition, the free, open source, light-weight and easy-to-use password manager.'
  homepage 'https://keepassxc.org/'
  version '2.7.9'
  license 'GPL-2 or GPL-3'
  compatibility 'x86_64'
  min_glibc '2.32'
  source_url "https://github.com/keepassxreboot/keepassxc/releases/download/#{version}/KeePassXC-#{version}-x86_64.AppImage"
  source_sha256 '2a868b681a8ec4e381ac14203aec3d80ff6fa7a535fa102265a3ec9329b4b846'

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

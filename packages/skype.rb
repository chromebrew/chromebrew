require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.87.0.403'
  license 'Skype-TOS'
  compatibility 'x86_64'
  source_url "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_#{version}_amd64.deb"
  source_sha256 '89bba0af5e5e450da06ef5fcc269369458a82cf493f658c0b967091c2a22f65f'

  no_compile_needed

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.ln_s './skypeforlinux', 'usr/bin/skype'
    FileUtils.mv Dir['usr/*'], CREW_DEST_PREFIX
  end

  def self.postinstall
    puts "\nType 'skype' to get started.\n".lightblue
  end
end

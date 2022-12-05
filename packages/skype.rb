require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.92.0.204'
  license 'Skype-TOS'
  compatibility 'x86_64'
  source_url 'https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_8.92.0.204_amd64.deb'
  source_sha256 'b08c22594c9fd81ce89d91261beed72f24e26832bb855020a91bbfbc847d7fb1'

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

require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.99.0.202'
  license 'Skype-TOS'
  compatibility 'x86_64'
  source_url 'https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_8.99.0.202_amd64.deb'
  source_sha256 '0c3f93617841a55f26a6f48d28bdc3e67ecda6b0d0896c15d63717273402ef10'

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

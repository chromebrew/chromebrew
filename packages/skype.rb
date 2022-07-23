require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.86.0.407'
  license 'Skype-TOS'
  compatibility 'x86_64'
  source_url "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_#{version}_amd64.deb"
  source_sha256 'e3a3342583f9401093091a8bb4dcab42c11ce8fb0ae9646cb1be792241baa6ed'

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

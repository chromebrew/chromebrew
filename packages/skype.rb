require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.110.76.107'
  license 'Skype-TOS'
  compatibility 'x86_64'
  source_url 'https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_8.110.76.107_amd64.deb'
  source_sha256 'a1c5e1212c04b70ccf77574e3e38088f9510ffcb2aab6814b6667c299040c4a3'

  no_compile_needed
  no_shrink

  depends_on 'gtk3'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.ln_s './skypeforlinux', 'usr/bin/skype'
    FileUtils.mv Dir['usr/*'], CREW_DEST_PREFIX
  end

  def self.postinstall
    puts "\nType 'skype' to get started.\n".lightblue
  end
end

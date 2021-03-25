require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.69.76.76'
  license 'Skype-TOS'
  compatibility 'x86_64'

  if ARCH == 'x86_64' then
    depends_on 'gtk3'
    depends_on 'sommelier'
    source_url "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_#{version}_amd64.deb"
    source_sha256 '30182e5d940993061956a7fd188ca56fbf3bc0852f7c6e8e6a46d44460db63c4'
  end

  def self.preinstall
    FileUtils.ln_s "#{CREW_PREFIX}/bin/skypeforlinux", 'usr/bin/skype'
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir.glob('usr/*'), CREW_DEST_PREFIX
  end
end

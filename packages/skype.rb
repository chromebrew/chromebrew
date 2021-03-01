require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.69.76.76'
  compatibility 'x86_64'
  
  if ARCH == 'x86_64' then
    depends_on 'gtk3'
    depends_on 'sommelier'
  end

  binary_url ({
     x86_64: "https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_#{version}_amd64.deb"
  })
  binary_sha256 ({
     x86_64: '30182e5d940993061956a7fd188ca56fbf3bc0852f7c6e8e6a46d44460db63c4'
  })
    
  is_external

  def self.preinstall
    FileUtils.ln_s "#{CREW_PREFIX}/bin/skypeforlinux", 'usr/bin/skype'
  end
  
  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir.glob('usr/*'), CREW_DEST_PREFIX
  end
end

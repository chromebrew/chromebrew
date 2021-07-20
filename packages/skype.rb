require 'package'

class Skype < Package
  description 'Skype is a telecommunications application that specializes in providing video chat and voice calls between devices'
  homepage 'https://www.skype.com/'
  version '8.73.0.92'
  license 'Skype-TOS'
  compatibility 'x86_64'

  depends_on 'gtk3'
  depends_on 'sommelier'
  source_url 'https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_8.73.0.92_amd64.deb'
  source_sha256 '5020d32e37179a38d940bbe7fddaed76f67e4e407fda915a10519c8694bfe972'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.ln_s "./skypeforlinux", 'usr/bin/skype'
    FileUtils.mv Dir['usr/*'], CREW_DEST_PREFIX
  end
end

require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  version '87.0'
  license 'MPL-2.0, GPL-2 and LGPL-2.1'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-i686/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '9127aee106dd9f09fac0c3cb89c5d75553384da4ec9be5943b60a5f55f31fccc'
  when 'x86_64'
    source_url "https://archive.mozilla.org/pub/firefox/releases/#{version}/linux-x86_64/en-US/firefox-#{version}.tar.bz2"
    source_sha256 '3c9207bee0a998634c4fd12293acfae207d16508749ad405bf1e8717d06acf02'
  end

  depends_on 'gtk2'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/firefox"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/firefox"
    FileUtils.ln_s "#{CREW_PREFIX}/firefox/firefox", "#{CREW_DEST_PREFIX}/bin/firefox"
  end
end

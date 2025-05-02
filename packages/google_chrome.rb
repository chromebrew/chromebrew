require 'package'
require 'convenience_functions'

class Google_chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome/'
  @update_channel = 'stable'
  version '136.0.7103.59-1'
  license 'google-chrome'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-#{@update_channel}/google-chrome-#{@update_channel}_#{@version}_amd64.deb"
  source_sha256 '7648bb0a2f753a9a8cb604bce329ecc415a807ceb6b7e796165c47bd95005237'

  depends_on 'nss'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/google/chrome', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s "#{CREW_PREFIX}/share/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end

  def self.postinstall
    ConvenienceFunctions.set_default_browser('Chrome', 'google-chrome')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('Chrome', 'google-chrome')
  end
end

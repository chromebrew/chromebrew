require 'package'

class Google_chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome/'
  version '141.0.7390.65-1'
  license 'google-chrome'
  compatibility 'x86_64'

  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_#{version}_amd64.deb"
  source_sha256 '55d8eb7eae7747a68f947de333703ca899e5b1426cea669cfebf8d019a9696ad'

  no_compile_needed
  no_shrink

  depends_on 'nss'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'

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

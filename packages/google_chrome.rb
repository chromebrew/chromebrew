require 'package'

class Google_chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome/'
  version '140.0.7339.207-1'
  license 'google-chrome'
  compatibility 'x86_64'

  source_url "https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_#{version}_amd64.deb"
  source_sha256 'e60d2df8410925e22d8ea2a24e9a79a84fdb9062a4c6f3af2dac61e630833ecb'

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

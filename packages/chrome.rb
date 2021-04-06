require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  @_ver = '89.0.4389.114'
  @_deb = "google-chrome-stable_#{@_ver}-1_amd64.deb"
  version @_ver
  license 'google-chrome'
  compatibility 'x86_64'
  source_url "https://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/#{@_deb}"
  source_sha256 '0ab92895e8b1b93a8d2591e0f89b32554af2ffc5a6f2bf9c1860a4ecb7a78b1b'

  depends_on 'nspr'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/google/chrome', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s "#{CREW_PREFIX}/share/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome-stable"
    FileUtils.ln_s "#{CREW_PREFIX}/share/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end
end

require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  @_ver = '90.0.4430.212'
  @_deb = "google-chrome-stable_#{@_ver}-1_amd64.deb"
  version @_ver
  license 'google-chrome'
  compatibility 'x86_64'
  source_url "https://dl.google.com/linux/deb/pool/main/g/google-chrome-stable/#{@_deb}"
  source_sha256 '274b473c4b4a3bcd0839e777ed466550daceae4352570ca4f342e824506163f8'

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

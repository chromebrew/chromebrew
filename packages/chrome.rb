require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  version '98.0.4758.102-1'
  license 'google-chrome'
  compatibility 'x86_64'
  source_url 'https://dl.google.com/linux/chrome/deb//pool/main/g/google-chrome-stable/google-chrome-stable_98.0.4758.102-1_amd64.deb'
  source_sha256 '864ffdeb9402ee82da2786e99c58547598762b281f34a14d8ad670ece654d95d'

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

    FileUtils.ln_s "../share/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome-stable"
    FileUtils.ln_s "../share/chrome/google-chrome", "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end
end

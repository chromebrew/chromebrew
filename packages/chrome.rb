require 'package'

class Chrome < Package
  description 'Google Chrome is a fast, easy to use, and secure web browser.'
  homepage 'https://www.google.com/chrome'
  version '111.0.5563.110-1'
  license 'google-chrome'
  compatibility 'x86_64'
  source_url 'https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_111.0.5563.110-1_amd64.deb'
  source_sha256 '20e61d34521bbbd18248e115f155ada26be15071fc76c074966588576243f0a2'

  depends_on 'nspr'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'expat'
  depends_on 'cras'
  depends_on 'sommelier'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mv 'opt/google/chrome', "#{CREW_DEST_PREFIX}/share"

    FileUtils.ln_s '../share/chrome/google-chrome', "#{CREW_DEST_PREFIX}/bin/google-chrome-stable"
    FileUtils.ln_s '../share/chrome/google-chrome', "#{CREW_DEST_PREFIX}/bin/google-chrome"
  end
end

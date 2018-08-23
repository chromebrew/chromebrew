require 'package'

class Poppler_data < Package
  description 'This additional package consists of encoding files for use with Poppler.'
  homepage 'https://poppler.freedesktop.org/'
  version '0.4.9'
  source_url 'https://poppler.freedesktop.org/poppler-data-0.4.9.tar.gz'
  source_sha256 '1f9c7e7de9ecd0db6ab287349e31bf815ca108a5a175cf906a90163bdbe32012'

  depends_on 'poppler'

  def self.install
    system "make --prefix=#{CREW_DEST_PREFIX} install"
  end
end

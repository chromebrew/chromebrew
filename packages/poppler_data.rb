require 'package'

class Poppler_data < Package
  description 'This additional package consists of encoding files for use with Poppler.'
  homepage 'https://poppler.freedesktop.org/'
  version '0.4.9'
  compatibility 'all'
  source_url 'https://poppler.freedesktop.org/poppler-data-0.4.9.tar.gz'
  source_sha256 '1f9c7e7de9ecd0db6ab287349e31bf815ca108a5a175cf906a90163bdbe32012'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler_data-0.4.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/poppler_data-0.4.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/poppler_data-0.4.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/poppler_data-0.4.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e87aab5e93dfef795acbc889688cee483685ceb1dae6623b77f3e902c676fc6e',
     armv7l: 'e87aab5e93dfef795acbc889688cee483685ceb1dae6623b77f3e902c676fc6e',
       i686: '45c2bfb58eae9b16e773a67d3c74a52f6d7096904d53495df6e710a1302bd41c',
     x86_64: 'cb660cd7accbdb437feb6704133040c74e09f80065a3c2020959385e31f4eec4',
  })

  depends_on 'poppler'

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end

require 'package'

class Pdfgrep < Package
  description 'a commandline utility to search text in PDF files'
  homepage 'https://pdfgrep.org/'
  version '2.0.1-1'
  compatibility 'all'
  source_url 'https://pdfgrep.org/download/pdfgrep-2.0.1.tar.gz'
  source_sha256 '0370d744b3072d47383dbed2cb9c8b0b64b83c084da5a8961f8d4bc7669e941e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pdfgrep-2.0.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pdfgrep-2.0.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pdfgrep-2.0.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pdfgrep-2.0.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0614122a56626fbc83ea82f36cacbb6fca7e5912cc0ff9b5fc343e5c67667da9',
     armv7l: '0614122a56626fbc83ea82f36cacbb6fca7e5912cc0ff9b5fc343e5c67667da9',
       i686: 'b74941e90fd939a1e8bf9f98b78267b53d8485225f629dd2972d401b96664e2b',
     x86_64: '6bcca42a2012f845c17f3c4111d9ec104a212c809bc98ce75985f21bb03e010c',
  })

  depends_on 'libgcrypt'
  depends_on 'pcre'
  depends_on 'poppler'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

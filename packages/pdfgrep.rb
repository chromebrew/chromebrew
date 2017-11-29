require 'package'

class Pdfgrep < Package
  description 'a commandline utility to search text in PDF files'
  homepage 'https://pdfgrep.org/'
  version '2.0.1-1'
  source_url 'https://pdfgrep.org/download/pdfgrep-2.0.1.tar.gz'
  source_sha256 '0370d744b3072d47383dbed2cb9c8b0b64b83c084da5a8961f8d4bc7669e941e'

  binary_url ({
  })
  binary_sha256 ({
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

require 'package'

class Txt2man < Package
  description 'Txt2man converts flat ASCII text to man page format.'
  homepage 'http://mvertes.free.fr/'
  version '1.5.6'
  source_url 'http://mvertes.free.fr/download/txt2man-1.5.6.tar.gz'
  source_sha256 '984825c5fd0cb3495160bf3277f327078081a8dc219dc466509e307ec9a2b52a'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/txt2man-1.5.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/txt2man-1.5.6-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/txt2man-1.5.6-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/txt2man-1.5.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'afc13f818d98119bc167d4357f0bea6f52313c389bfa417689ad9cc05512e74a',
     armv7l: 'afc13f818d98119bc167d4357f0bea6f52313c389bfa417689ad9cc05512e74a',
       i686: '9c6f35e9545135ee00d50cf0dcc3472b9481cd400dbb5de01f8b9958cd35bdfa',
     x86_64: 'c5f02fa1b28720f66e4be6de5fd096664945b48208fb97775e9fee1368361a34',
  })

  depends_on 'gawk'
  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

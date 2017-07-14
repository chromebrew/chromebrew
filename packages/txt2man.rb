require 'package'

class Txt2man < Package
  description 'Txt2man converts flat ASCII text to man page format.'
  homepage 'http://mvertes.free.fr/'
  version '1.5.6'
  source_url 'http://mvertes.free.fr/download/txt2man-1.5.6.tar.gz'
  source_sha256 '984825c5fd0cb3495160bf3277f327078081a8dc219dc466509e307ec9a2b52a'

  depends_on 'gawk'
  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

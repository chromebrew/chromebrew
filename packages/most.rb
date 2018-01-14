require 'package'

class Most < Package
  description 'MOST is a powerful paging program for Unix, VMS, MSDOS, and win32 systems.'
  homepage 'http://www.jedsoft.org/most/'
  version 'pre5.1-20'
  source_url 'https://www.jedsoft.org/snapshots/most-pre5.1-20.tar.gz'
  source_sha256 '59b02c9f131c5fb0e20f952ca34bcf90919251f585bbf014dfb5c281d699388d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'slang'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Aspell < Package
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.7-rc1-2'
  source_url 'ftp://alpha.gnu.org/gnu/aspell/aspell-0.60.7-rc1.tar.gz'
  source_sha256 '86b5662f24316142f70c5890787bdc5596625ca3604dfe85926ee61f27f2365e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ruby' unless File.exists? '/usr/local/bin/ruby'
  depends_on 'ncursesw'

  def self.build
    system "./configure --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

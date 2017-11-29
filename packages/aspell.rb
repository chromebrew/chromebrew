require 'package'

class Aspell < Package
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.7-rc1-3'
  source_url 'ftp://alpha.gnu.org/gnu/aspell/aspell-0.60.7-rc1.tar.gz'
  source_sha256 '86b5662f24316142f70c5890787bdc5596625ca3604dfe85926ee61f27f2365e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-rc1-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-rc1-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-rc1-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell-0.60.7-rc1-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f8766f3cd6f6a4f7fe041272e3bc391d7c071090fffcdcad1b65b78964b600e',
     armv7l: '9f8766f3cd6f6a4f7fe041272e3bc391d7c071090fffcdcad1b65b78964b600e',
       i686: '90415e00c5bf27d48389c328e5ad3709c3e8daf7848909218c34c4df91ecd9d2',
     x86_64: '78b3b2afb62be606d399344c0320f586e22901c922324953fab77a6b88d5373b',
  })

  depends_on 'ruby' unless File.exists? "#{CREW_PREFIX}/bin/ruby"
  depends_on 'ncursesw'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

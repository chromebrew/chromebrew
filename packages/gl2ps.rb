require 'package'

class Gl2ps < Package
  description 'An OpenGL to PostScript printing library'
  homepage 'http://geuz.org/gl2ps/'
  version '1.4.2'
  compatibility 'all'
  source_url 'http://geuz.org/gl2ps/src/gl2ps-1.4.2.tgz'
  source_sha256 '8d1c00c1018f96b4b97655482e57dcb0ce42ae2f1d349cd6d4191e7848d9ffe9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gl2ps-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gl2ps-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gl2ps-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gl2ps-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ce3401bfc43e361043c923abb4678cc430549a2268e0b167e2e07e147885fabb',
     armv7l: 'ce3401bfc43e361043c923abb4678cc430549a2268e0b167e2e07e147885fabb',
       i686: '57b21122bbdfe8dcc971705e5b90696fbea8b97420e90c5c86b26ece1c47ceb9',
     x86_64: 'dba42db2af724a91462fd720ac3f5b910aa270a91b7813e9478927924de836a8',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      if ARCH == 'x86_64'
        FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
        FileUtils.mv Dir.glob("#{CREW_DEST_PREFIX}/lib/*"), "#{CREW_DEST_LIB_PREFIX}"
      end
    end
  end
end

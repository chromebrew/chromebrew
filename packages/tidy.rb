require 'package'

class Tidy < Package
  description 'The granddaddy of HTML tools, with support for modern standards'
  homepage 'http://www.html-tidy.org/'
  version '5.6.0'
  compatibility 'all'
  source_url 'https://github.com/htacg/tidy-html5/archive/5.6.0.tar.gz'
  source_sha256 '08a63bba3d9e7618d1570b4ecd6a7daa83c8e18a41c82455b6308bc11fe34958'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tidy-5.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tidy-5.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tidy-5.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tidy-5.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cff1c1a6c12ac5503db6d5d38b674069df305dfdf5abe327af57f4fe10559b07',
     armv7l: 'cff1c1a6c12ac5503db6d5d38b674069df305dfdf5abe327af57f4fe10559b07',
       i686: '34c25a0930741ae084808c6008d9103efcdbc7d0f2e4fade64f6d4c9d239cdd2',
     x86_64: 'd132e0477d2273b7b9a5077b5389b0325f3dfeaed7516a632fa14620ab32e95e',
  })

  def self.build
    Dir.chdir 'build/cmake' do
      case ARCH
      when 'x86_64'
        system "cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_SUFFIX=64"
      else
        system "cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
      end
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build/cmake' do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end

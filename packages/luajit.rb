require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'http://luajit.org/'
  version '2.0.5-1'
  source_url 'https://luajit.org/download/LuaJIT-2.0.5.tar.gz'
  source_sha256 '874b1f8297c697821f561f9b73b57ffd419ed8f4278c82e05b48806d30c1e979'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-1-chromeos-x86_64.tar.xz',
  })

  binary_sha256 ({
    aarch64: 'd32a0eec31c33ff6c8e4ef0de7b8859eb82b5068bbc0ff2977036f8400fb680b',
     armv7l: 'd32a0eec31c33ff6c8e4ef0de7b8859eb82b5068bbc0ff2977036f8400fb680b',
       i686: 'a6dfb5c8fb1af263061791896bda261d61b0266707b0959a75225877ae16b306',
     x86_64: 'c00c619ea846133a8c660e908184d8012ed0b1821a8574605149ec19dacc8efd',
  })

  def self.build
    system 'make'
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

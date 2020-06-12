require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'http://luajit.org/'
  version '2.0.5-2'
  compatibility 'all'
  source_url 'https://luajit.org/download/LuaJIT-2.0.5.tar.gz'
  source_sha256 '874b1f8297c697821f561f9b73b57ffd419ed8f4278c82e05b48806d30c1e979'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0518de335a3dc8ac04d9bcbe476d3cf2f053c058737d57f6d723c31c6eb59c99',
     armv7l: '0518de335a3dc8ac04d9bcbe476d3cf2f053c058737d57f6d723c31c6eb59c99',
       i686: '4942a96c905bdbc35026f9737cf55e7ca9879f06bfe9923229aeeb51039fe96b',
     x86_64: 'd95af6ff12ca102dfad963a0606b5e2181f9e3fd68788b470f21de580f52142b',
  })

  def self.build
    system "make", "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "MULTILIB=#{ARCH_LIB}", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "ln -sf #{CREW_LIB_PREFIX}/libluajit-5.1.so.2.0.5 #{CREW_DEST_LIB_PREFIX}/libluajit-5.1.so.2"
    system "ln -sf #{CREW_LIB_PREFIX}/libluajit-5.1.so.2.0.5 #{CREW_DEST_LIB_PREFIX}/libluajit-5.1.so"
  end
end

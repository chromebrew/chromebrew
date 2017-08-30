require 'package'

class Luajit < Package
  description 'LuaJIT is a Just-In-Time Compiler (JIT) for the Lua programming language.'
  homepage 'http://luajit.org/'
  version '2.0.5'
  source_url 'http://luajit.org/download/LuaJIT-2.0.5.tar.gz'
  source_sha256 '874b1f8297c697821f561f9b73b57ffd419ed8f4278c82e05b48806d30c1e979'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/luajit-2.0.5-chromeos-x86_64.tar.xz',
  })

  binary_sha256 ({
    aarch64: 'd850b02b9d4b02f73802359bed9a26dc672c741009c3d956174f86e7163e1efc',
     armv7l: 'd850b02b9d4b02f73802359bed9a26dc672c741009c3d956174f86e7163e1efc',
       i686: '2cd205c4b3b654fe2f4eb6bc6e2460c6a663b4984804462db7af635363799440',
     x86_64: '53411d401c9da988d6588c3c882df13feaeefb889a5ae5f0ba6a14d52fadd302',
  })

  depends_on 'buildessential' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

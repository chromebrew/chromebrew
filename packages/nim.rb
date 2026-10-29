require 'package'

class Nim < Package
  description 'Nim is a statically typed compiled systems programming language.'
  homepage 'https://nim-lang.org/'
  version '2.4.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://nim-lang.org/download/nim-#{version}.tar.xz"
  source_sha256 '4fa00853bc6ac92ebdd924d8e2ce42509d3f708d76a3ffcc034e16288e0e0325'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8dce3649e96ae9042b584ed35f888c52ba1deb1873f887ad4a785b6e99751f9f',
     armv7l: '8dce3649e96ae9042b584ed35f888c52ba1deb1873f887ad4a785b6e99751f9f',
       i686: 'e41e47b9e11e3f801d4e0f3fb839ecdcc60e47117ade7b708da8165fae85d6b3',
     x86_64: '838bea4c39e0b2367f758d555de6a4adb6705cef0361e3cac93c3b3c44dace3f'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'pcre' => :executable

  def self.patch
    system 'sed -i "s,^ucpu=.*,ucpu=\"arm\"," build.sh' if ARCH == 'aarch64'
    system "sed -i \"s,/usr/local,#{CREW_DEST_PREFIX},g\" install.sh"
  end

  def self.build
    if ARCH == 'i686'
      # Fix fatal error: nimbase.h: No such file or directory.
      system 'CFLAGS+=" -I$(pwd)/lib" ./build.sh'
    else
      system './build.sh'
    end
    system 'bin/nim c koch'
    system './koch boot -d:release'
    if ARCH == 'i686'
      # Fix SYS_getrandom undeclared. See https://github.com/nim-lang/Nim/issues/19052.
      system './koch tools -d:nimNoGetRandom'
    else
      system './koch tools'
    end
  end

  def self.install
    system "./install.sh #{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nim/bin/nim", "#{CREW_DEST_PREFIX}/bin/nim"
  end
end

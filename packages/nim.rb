require 'package'

class Nim < Package
  description 'Nim is a statically typed compiled systems programming language.'
  homepage 'https://nim-lang.org/'
  version '2.4.2'
  license 'MIT'
  compatibility 'all'
  source_url "https://nim-lang.org/download/nim-#{version}.tar.xz"
  source_sha256 'b28bf4da1fce46dba9d16685c981b3d5e98de8db1b60d66f279b0bd2af2d8211'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e06229e8c68e78d8b4c5a0d58cdb1ffbecc84b26e0b6071add1e56c393dc08bf',
     armv7l: 'e06229e8c68e78d8b4c5a0d58cdb1ffbecc84b26e0b6071add1e56c393dc08bf',
       i686: '4dd564e3ab9a0e462526bee283549c90cf1d678ab81af26ce2e4c554ecffceb7',
     x86_64: '6d1b7c3ea9ed519e925ef790d39bd782dd5ded8b57368aa591cf7ae5f2b350f8'
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

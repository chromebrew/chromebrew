# Adapted from Arch Linux duktape PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/duktape/trunk/PKGBUILD

require 'package'

class Duktape < Package
  description 'Embeddable Javascript engine'
  homepage 'https://duktape.org/'
  version '2.6.0'
  compatibility 'all'
  license 'MIT'
  source_url "https://duktape.org/duktape-#{version}.tar.xz"
  source_sha256 '96f4a05a6c84590e53b18c59bb776aaba80a205afbbd92b82be609ba7fe75fa7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duktape/2.6.0_armv7l/duktape-2.6.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duktape/2.6.0_armv7l/duktape-2.6.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duktape/2.6.0_i686/duktape-2.6.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duktape/2.6.0_x86_64/duktape-2.6.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c734d031be824d9bdaa17efe89f88a527e585fdd4665ec406251d0451ad1b77f',
     armv7l: 'c734d031be824d9bdaa17efe89f88a527e585fdd4665ec406251d0451ad1b77f',
       i686: '5e4bfca44b948812f3f20730ff779c7d92358dca39e958105a011cbb856069da',
     x86_64: '5f5787b8f9893d2b838e41c9391022f7fd9f0f7bacf45059b40e061ec7654ed1'
  })

  depends_on 'setconf' => :build

  def self.build
    FileUtils.mv 'Makefile.sharedlibrary', 'Makefile'
    system "sed -i 's/-Wall -Wextra/$(CFLAGS) -D DUK_USE_FASTINT -w/g' Makefile"
    system "sed -i 's,$(INSTALL_PREFIX)/lib,#{CREW_DEST_LIB_PREFIX},g' Makefile"
    system "setconf Makefile INSTALL_PREFIX #{CREW_DEST_PREFIX}"
    @duktapepc = <<~DUKTAPEPCEOF
      prefix=#{CREW_PREFIX}
      exec_prefix=\${prefix}
      libdir=#{CREW_LIB_PREFIX}
      includedir=\${prefix}/include

      Name: duktape
      Description: Embeddable Javascript engine
      Version: #{version}
      Libs: -L\${libdir} -lduktape
      Cflags: -I\${includedir}
    DUKTAPEPCEOF
    File.write('duktape.pc', @duktapepc)
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_LIB_PREFIX}/pkgconfig]
    FileUtils.install 'duktape.pc', "#{CREW_DEST_LIB_PREFIX}/pkgconfig/duktape.pc", mode: 0o644
    system 'make install'
  end
end

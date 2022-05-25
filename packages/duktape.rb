# Adapted from Arch Linux duktape PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/duktape/trunk/PKGBUILD

require 'package'

class Duktape < Package
  description 'Embeddable Javascript engine'
  homepage 'https://duktape.org/'
  version '2.7.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://duktape.org/duktape-#{version}.tar.xz"
  source_sha256 '90f8d2fa8b5567c6899830ddef2c03f3c27960b11aca222fa17aa7ac613c2890'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duktape/2.7.0_armv7l/duktape-2.7.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duktape/2.7.0_armv7l/duktape-2.7.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duktape/2.7.0_i686/duktape-2.7.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duktape/2.7.0_x86_64/duktape-2.7.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9d20adb7b8948b3f8109de81c39ef477b3ec1d50fe7adde2ad6029d49f834bc7',
     armv7l: '9d20adb7b8948b3f8109de81c39ef477b3ec1d50fe7adde2ad6029d49f834bc7',
       i686: '30b287b4a28f993215998be0bfe145d134d60dac3656e19da78dd9ea76d1db7e',
     x86_64: '11fa2e446783af1230ba5df5e628460a8875a35c0e542de441778fa7301d9826'
  })

  depends_on 'setconf' => :build
  depends_on 'glibc' # R

  def self.build
    FileUtils.mv 'Makefile.sharedlibrary', 'Makefile'
    system "sed -i 's/-Wall -Wextra/$(CFLAGS) -D DUK_USE_FASTINT -w/g' Makefile"
    system "sed -i 's,$(INSTALL_PREFIX)/lib,#{CREW_DEST_LIB_PREFIX},g' Makefile"
    system "setconf Makefile INSTALL_PREFIX #{CREW_DEST_PREFIX}"
    @duktapepc = <<~DUKTAPEPCEOF
      prefix=#{CREW_PREFIX}
      exec_prefix=${prefix}
      libdir=#{CREW_LIB_PREFIX}
      includedir=${prefix}/include

      Name: duktape
      Description: Embeddable Javascript engine
      Version: #{version}
      Libs: -L${libdir} -lduktape
      Cflags: -I${includedir}
    DUKTAPEPCEOF
    File.write('duktape.pc', @duktapepc)
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_LIB_PREFIX}/pkgconfig]
    FileUtils.install 'duktape.pc', "#{CREW_DEST_LIB_PREFIX}/pkgconfig/duktape.pc", mode: 0o644
    system 'make install'
  end
end

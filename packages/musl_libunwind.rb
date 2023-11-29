require 'package'

class Musl_libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.5.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.5.0.tar.gz'
  source_sha256 '90337653d92d4a13de590781371c604f9031cdb50520366aa1e3a91e1efb1017'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunwind/1.5.0_armv7l/musl_libunwind-1.5.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunwind/1.5.0_armv7l/musl_libunwind-1.5.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunwind/1.5.0_i686/musl_libunwind-1.5.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunwind/1.5.0_x86_64/musl_libunwind-1.5.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6c8cd877134f2b8b79ae166aff8d08fa782fecac5dbbb70a937d3a0f6cd65588',
     armv7l: '6c8cd877134f2b8b79ae166aff8d08fa782fecac5dbbb70a937d3a0f6cd65588',
       i686: 'b350166133b7d657c2316740f8a3e236ff4653c9ce7b9842b473f6bf153d8465',
     x86_64: '52eb28cf1ae245e52084699cdc1bc18e604f3a9d2b1ac2c5a4fd82b2548a2d8c'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libbacktrace' => :build
  depends_on 'musl_libucontext' => :build

  def self.patch
    # As per https://www.linuxquestions.org/questions/linux-software-2/building-libunwind-on-x86-musl-libc-against-libucontext-4175692781/#post6235105
    # https://archive.md/gaEbN
    case ARCH
    when 'aarch64', 'armv7l'
      @arch = 'arm'
    when 'i686'
      @arch = 'x86'
    when 'x86_64'
      @arch = 'x86_64'
    end
    system "sed -i '1i#include <ucontext.h>\' src/#{@arch}/Gos-linux.c"
    system 'filefix'
  end

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
      --enable-shared \
      --enable-static \
      --enable-ptrace \
      --disable-tests"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

require 'package'

class Musl_libunistring < Package
  description 'A library that provides functions for manipulating Unicode strings and for manipulating C strings according to the Unicode standard.'
  homepage 'https://www.gnu.org/software/libunistring/'
  version '0.9.10-1'
  license 'LGPL-3+ or GPL-2+ and FDL-1.2 or GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libunistring/libunistring-0.9.10.tar.xz'
  source_sha256 'eb8fb2c3e4b6e2d336608377050892b54c3c983b646c561836550863003c05d7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunistring/0.9.10-1_armv7l/musl_libunistring-0.9.10-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunistring/0.9.10-1_armv7l/musl_libunistring-0.9.10-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunistring/0.9.10-1_i686/musl_libunistring-0.9.10-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunistring/0.9.10-1_x86_64/musl_libunistring-0.9.10-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7993833f0c924bbe1cc0886181287cf52a74252660ccdf7de9db2ca0f58fbf17',
     armv7l: '7993833f0c924bbe1cc0886181287cf52a74252660ccdf7de9db2ca0f58fbf17',
       i686: '460681fc32028b10be1365826a902e3f24e707a6d3fa45f038554af41d3494bc',
     x86_64: '2ab6bc568ddd929c7cab3bf14fc2ad44746cbb943e3cbf896c10f28220a8a4e8'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_zlib' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
        --enable-static \
        --disable-shared"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # avoid conflict with musl_libidn2
    FileUtils.rm_f "#{CREW_DEST_MUSL_PREFIX}/share/info/dir"
  end
end

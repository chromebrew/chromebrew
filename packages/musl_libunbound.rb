require 'package'

class Musl_libunbound < Package
  description 'Unbound is a validating, recursive, and caching DNS resolver.'
  homepage 'https://nlnetlabs.nl/projects/unbound/about/'
  @_ver = '1.14.0'
  version @_ver
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://nlnetlabs.nl/downloads/unbound/unbound-#{@_ver}.tar.gz"
  source_sha256 '6ef91cbf02d5299eab39328c0857393de7b4885a2fe7233ddfe3c124ff5a89c8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunbound/1.14.0_armv7l/musl_libunbound-1.14.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunbound/1.14.0_armv7l/musl_libunbound-1.14.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunbound/1.14.0_i686/musl_libunbound-1.14.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunbound/1.14.0_x86_64/musl_libunbound-1.14.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6a4fff3a80696455b624ae2ba0e1304148142390bfbf363e571d3deb927f67f3',
     armv7l: '6a4fff3a80696455b624ae2ba0e1304148142390bfbf363e571d3deb927f67f3',
       i686: 'f72c7bdb7092fc431f5b99c37b2350975410b268c8c92ef768503bca8c285692',
     x86_64: 'f25952a3c365543c2404da2b0b14138d8dfa7caac01e1cadf6444fcaa37b5e4f'
  })

  depends_on 'musl_openssl' => :build
  depends_on 'musl_expat' => :build
  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.patch
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system 'filefix'
  end

  def self.build
    system './configure --help'
    system "#{MUSL_ENV_OPTIONS} ./configure \
      --prefix=#{CREW_MUSL_PREFIX} \
      --disable-shared \
      --enable-static \
      --with-pic \
      --with-ssl=#{CREW_MUSL_PREFIX} \
      --with-libexpat=#{CREW_MUSL_PREFIX} \
      --with-libunbound-only"
    system 'make'
  end

  def self.check
    # tests are broken on musl for this.
    # system 'make', 'test'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end

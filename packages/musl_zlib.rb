require 'package'

class Musl_zlib < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  @_ver = '1.2.11'
  version "#{@_ver}-1"
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zlib/1.2.11-1_armv7l/musl_zlib-1.2.11-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zlib/1.2.11-1_armv7l/musl_zlib-1.2.11-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zlib/1.2.11-1_i686/musl_zlib-1.2.11-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_zlib/1.2.11-1_x86_64/musl_zlib-1.2.11-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2ef3cfd50efbcd094cba24b4a776fe95f655f1ab9e36c3186355c3c710b95235',
     armv7l: '2ef3cfd50efbcd094cba24b4a776fe95f655f1ab9e36c3186355c3c710b95235',
       i686: '5e36e9ad564e7323524be1bcc6ba1ea5a5d161b37c2dc3a0b05bcd1daa7c6783',
     x86_64: '3258869aa53a18df34f79f150becf9d1e6d2e69ee2a2ab6c31aa131981ae54f3'
  })

  depends_on 'musl_native_toolchain' => :build

  is_static

  def self.build
    load "#{CREW_LIB_PATH}lib/musl.rb"
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
          --static"
    system "#{MUSL_ENV_OPTIONS} make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

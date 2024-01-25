require 'package'

class Musl_zlib < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  @_ver = '1.2.11'
  version "#{@_ver}-3"
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '571117513b5a9668145ab0bdd54202644cb4f0d955c36e1f87e7cb6f1db65eb7',
     armv7l: '571117513b5a9668145ab0bdd54202644cb4f0d955c36e1f87e7cb6f1db65eb7',
       i686: '8cb92c4a79f090c3ad19002a62d23d401aa73fbe36d9038fbca2e9e4df6557ab',
     x86_64: 'c5f536dffcc2be62f4c5f131531418b4b4b24b6d27b7bc9dd531ea9a05f04074'
  })

  depends_on 'musl_native_toolchain' => :build
  is_musl
  patchelf
  is_static

  def self.build
    system "#{MUSL_ENV_OPTIONS} ./configure --prefix=#{CREW_MUSL_PREFIX} \
          --static"
    system "#{MUSL_ENV_OPTIONS} make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

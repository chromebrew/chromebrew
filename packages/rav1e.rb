require 'package'

class Rav1e < Package
  description 'An AV1 encoder focused on speed and safety'
  homepage 'https://github.com/xiph/rav1e/'
  @_ver = '0.5.0-alpha'
  version @_ver
  license 'BSD-2, Apache-2.0, MIT and Unlicense'
  compatibility 'all'
  source_url "https://github.com/xiph/rav1e/archive/v#{@_ver}.tar.gz"
  source_sha256 'fd884fa387d01860eaf22a0a97353525221eb32bf6b9154bbfa21b6cce5988c8'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/rav1e-0.5.0-alpha-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/rav1e-0.5.0-alpha-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/rav1e-0.5.0-alpha-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/rav1e-0.5.0-alpha-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd02192b1152145b31bb1192d79ca40cb722d3c550b7471020e30bfac69448571',
     armv7l: 'd02192b1152145b31bb1192d79ca40cb722d3c550b7471020e30bfac69448571',
       i686: 'f17b429706232d8cd66e9b3368afd7211966dc23b11f8d448dada93cca8460db',
     x86_64: '2c05f46c0361e5fc0b2e40fbd62561c0383eb2dd2b140a3d77a1fd3fc263a07f'
  })

  depends_on 'rust' => :build
  depends_on 'cargo_c' => :build

  def self.build
    system "cargo fetch \
      --manifest-path Cargo.toml"
    system "cargo build \
      --release \
      --frozen \
      --manifest-path Cargo.toml"
    system "cargo cbuild \
      --release \
      --frozen \
      --prefix=#{CREW_PREFIX} \
      --manifest-path Cargo.toml"
  end

  def self.install
    system "cargo install \
      --frozen \
      --offline \
      --no-track \
      --path . \
      --root #{CREW_DEST_PREFIX}"
    system "cargo cinstall \
      --frozen \
      --offline \
      --prefix=#{CREW_PREFIX} \
      --destdir=#{CREW_DEST_DIR} \
      --libdir=#{CREW_LIB_PREFIX}"
  end
end

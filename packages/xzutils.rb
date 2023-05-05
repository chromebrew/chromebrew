require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.4.3'
  license 'public-domain, LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://tukaani.org/xz/xz-5.4.3.tar.gz'
  source_sha256 '1c382e0bc2e4e0af58398a903dd62fff7e510171d2de47a1ebe06d1528e9b7e9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.3_armv7l/xzutils-5.4.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.3_armv7l/xzutils-5.4.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.3_i686/xzutils-5.4.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.4.3_x86_64/xzutils-5.4.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '423d4266d49d82aceb6341b5d2bce7d3416ff06fb1f026f4acab0584338913c9',
     armv7l: '423d4266d49d82aceb6341b5d2bce7d3416ff06fb1f026f4acab0584338913c9',
       i686: '82b65794ce833407142d7183d6ec497f69ba7399df5582b5335d30270c57585c',
     x86_64: '60ffcc7daaa04574fb5624b0be54c5db39e52da3c786dc4ed2d4dc628211ab92'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh --no-po4a'
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-docs \
      --enable-shared"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

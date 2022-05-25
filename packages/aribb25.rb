require 'package'

class Aribb25 < Package
  description 'aribb25 is a basic implementation of the ARIB STD-B25 public standard.'
  homepage 'https://code.videolan.org/videolan/aribb25/'
  version '0.2.7'
  compatibility 'all'
  license 'ISC'
  source_url 'https://code.videolan.org/videolan/aribb25.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aribb25/0.2.7_armv7l/aribb25-0.2.7-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aribb25/0.2.7_armv7l/aribb25-0.2.7-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aribb25/0.2.7_i686/aribb25-0.2.7-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aribb25/0.2.7_x86_64/aribb25-0.2.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '21290fa231ac801bbafbcf7c6f16e588257d241560e81999df3014e48c15715e',
      armv7l: '21290fa231ac801bbafbcf7c6f16e588257d241560e81999df3014e48c15715e',
        i686: 'c69200d277d2d2f7bcd24a3133c9c0e99d288c15e36231550f91f22b38f1e928',
      x86_64: '8efc2a4ebaf94e5f556882b80b86dd5cecdecc7e3029b7e14b2a6fb9fd914b12'
  })

  depends_on 'pcsc_lite'

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end

require 'package'

class Liba52 < Package
  description 'liba52 is a free library for decoding ATSC A/52 streams.'
  homepage 'http://liba52.sourceforge.net/'
  @_ver = '0.7.4'
  version "#{@_ver}-1"
  compatibility 'all'
  license 'GPL-2+'
  source_url 'https://salsa.debian.org/multimedia-team/a52dec.git'
  git_hashtag "debian/#{@_ver}-20"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liba52/0.7.4-1_armv7l/liba52-0.7.4-1-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liba52/0.7.4-1_armv7l/liba52-0.7.4-1-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liba52/0.7.4-1_i686/liba52-0.7.4-1-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/liba52/0.7.4-1_x86_64/liba52-0.7.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '106c1cfcb9b7eb7a0dcc891d7586abacddc422f667da68dbd8260f13c7c0d6f3',
      armv7l: '106c1cfcb9b7eb7a0dcc891d7586abacddc422f667da68dbd8260f13c7c0d6f3',
        i686: '5d8f45e6a52ee96c54330c624fd66c64b75efd58d20049fdaf7fbe317b6d1bc6',
      x86_64: '8473516c95e4e2356bf3311ea689b430117b0324b30b4aa06785eb17497136ef'
  })

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
  end

  def self.build
    system './bootstrap'
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

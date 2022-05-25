require 'package'

class Libmpeg2 < Package
  description 'libmpeg2 is a free MPEG-2 video stream decoder.'
  homepage 'https://libmpeg2.sourceforge.io/'
  @_ver = '0.5.1'
  version "#{@_ver}-1"
  compatibility 'all'
  license 'GPL-2'
  source_url 'https://salsa.debian.org/multimedia-team/mpeg2dec.git'
  git_hashtag "debian/#{@_ver}-9"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpeg2/0.5.1-1_armv7l/libmpeg2-0.5.1-1-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpeg2/0.5.1-1_armv7l/libmpeg2-0.5.1-1-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpeg2/0.5.1-1_i686/libmpeg2-0.5.1-1-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmpeg2/0.5.1-1_x86_64/libmpeg2-0.5.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5b5fdf553d59930d1d3df204c2b7f32c0665b7623bc83b4a88c1ffa70f7d7e7c',
      armv7l: '5b5fdf553d59930d1d3df204c2b7f32c0665b7623bc83b4a88c1ffa70f7d7e7c',
        i686: '0db4a3fa3b213291913097daa878fd6e760eed1a43b64107ce940ef869a703a3',
      x86_64: '6d148c52e28455fdd06b2797bcd99a0a36ae21319e998bece8945189c8fcf3ae'
  })

  depends_on 'libx11'

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\${i}; done"
    # system "sed '60d' bootstrap" # Our automake version is greater than 1.5
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-x"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end

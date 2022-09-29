require 'package'

class Re2c < Package
  description 're2c is a free and open-source lexer generator for C and C++.'
  homepage 'http://re2c.org/'
  version '3.0-1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/skvadrik/re2c/releases/download/3.0/re2c-3.0.tar.lz'
  source_sha256 '39757db2defc21a6713560cdff75895fb30f02af22a3ac8066fd9ba84f16a1b3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/3.0-1_armv7l/re2c-3.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/3.0-1_armv7l/re2c-3.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/3.0-1_i686/re2c-3.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/3.0-1_x86_64/re2c-3.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e7bd792f3befad5c69622bf54d20c77f029b40ca40a3a0f223e380b79b9d6fd9',
     armv7l: 'e7bd792f3befad5c69622bf54d20c77f029b40ca40a3a0f223e380b79b9d6fd9',
       i686: '1ab8a1859f894f9e1d8581007cd62f8095fee0b43e60e954a824c8fd70e270f6',
     x86_64: '2deeb6677004c222983ed9a2841f4e14e45010d8fefd0cc06f6b6d3fe623c7db'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "mold -run cmake \
          #{CREW_CMAKE_OPTIONS} \
          -Wdev \
          -G Ninja \
          .."
      system 'mold -run samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end

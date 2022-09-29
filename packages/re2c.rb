require 'package'

class Re2c < Package
  description 're2c is a free and open-source lexer generator for C and C++.'
  homepage 'http://re2c.org/'
  version '3.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/skvadrik/re2c/releases/download/3.0/re2c-3.0.tar.lz'
  source_sha256 '39757db2defc21a6713560cdff75895fb30f02af22a3ac8066fd9ba84f16a1b3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/3.0_armv7l/re2c-3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/3.0_armv7l/re2c-3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/3.0_i686/re2c-3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/re2c/3.0_x86_64/re2c-3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2d26bed05dd891ca9111f32fefb93e731ff075091e73780cac8978d87860185e',
     armv7l: '2d26bed05dd891ca9111f32fefb93e731ff075091e73780cac8978d87860185e',
       i686: '66382a147c0f35c6b66f80b1ff11191cd46a40f5134a0a740a1073c09b27242f',
     x86_64: 'b84773fba0c9890b2128edc28925f3b4d827ed34f56f58204f6e2cba65d7bf3d'
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

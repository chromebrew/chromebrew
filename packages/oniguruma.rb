require 'package'

class Oniguruma < Package
  description 'Oniguruma is a modern and flexible regular expressions library.'
  homepage 'https://github.com/kkos/oniguruma'
  version '6.9.7.1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/kkos/oniguruma.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '61e2b0c0a8096bc2acdb1d311021786c08c0a47298fab2a063e2821c19b95f28',
     armv7l: '61e2b0c0a8096bc2acdb1d311021786c08c0a47298fab2a063e2821c19b95f28',
       i686: 'e0c27b9259019fc5c1461d689a47cad568e7636de9480086e3e22aec8854c2e4',
     x86_64: 'bd6365ccee10f95b6091eecf8b23e96a0b30f87a1b9c71f120dabcaa9f5c6cee'
  })

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

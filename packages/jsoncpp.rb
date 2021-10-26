require 'package'

class Jsoncpp < Package
  description 'A C++ library for interacting with JSON.'
  homepage 'https://github.com/open-source-parsers/jsoncpp'
  version '1.9.4'
  license 'MIT, public-domain'
  compatibility 'all'
  source_url 'https://github.com/open-source-parsers/jsoncpp.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsoncpp/1.9.4_armv7l/jsoncpp-1.9.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsoncpp/1.9.4_armv7l/jsoncpp-1.9.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsoncpp/1.9.4_i686/jsoncpp-1.9.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsoncpp/1.9.4_x86_64/jsoncpp-1.9.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7f0d44ddf2a5196e3bf4d2f69e6183ffed4298789f2bedc96b31c67171fba943',
     armv7l: '7f0d44ddf2a5196e3bf4d2f69e6183ffed4298789f2bedc96b31c67171fba943',
       i686: '7cd8992a5be92d4a670a678ef6c6fd4e91ed6ffa309923b23b6e11141566cf3f',
     x86_64: 'e76dabf5643b8aea91de16d39b6563adcf081e2b32c732b3a9f7663b6a1104c9'
  })

  depends_on 'meson'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja test -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

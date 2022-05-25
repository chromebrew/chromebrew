require 'package'

class Jsoncpp < Package
  description 'A C++ library for interacting with JSON.'
  homepage 'https://github.com/open-source-parsers/jsoncpp'
  version '1.9.4'
  license 'MIT, public-domain'
  compatibility 'all'
  source_url 'https://github.com/open-source-parsers/jsoncpp.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsoncpp/1.9.4_armv7l/jsoncpp-1.9.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsoncpp/1.9.4_armv7l/jsoncpp-1.9.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsoncpp/1.9.4_i686/jsoncpp-1.9.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsoncpp/1.9.4_x86_64/jsoncpp-1.9.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '71fb94fdc4876273871a39cac3dbb84e0695a27aa307acb2601f227c374313bb',
     armv7l: '71fb94fdc4876273871a39cac3dbb84e0695a27aa307acb2601f227c374313bb',
       i686: '45cfb7ba6a35022261b262b813a99654046a08d4ccc67d496465b72337157b7a',
     x86_64: '5496a7bb46dd54ee680ef70955f1259cf3c0173a2f8bf8c518458ecce5cb1f9e'
  })

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'samu -C builddir'
  end

  def self.check
    system 'samu test -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end

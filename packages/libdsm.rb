require 'package'

class Libdsm < Package
  description 'Defective SMb: A minimalist implementation of a client library for SMB using C.'
  homepage 'https://videolabs.github.io/libdsm/'
  version '0.3.2'
  compatibility 'all'
  license 'LGPL-2.1+'
  source_url 'https://github.com/videolabs/libdsm.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '0f1cfa4ecfd15ce2638be2e8bd85538898cada850ed99beea1247f928b22625b',
      armv7l: '0f1cfa4ecfd15ce2638be2e8bd85538898cada850ed99beea1247f928b22625b',
        i686: '08f6535b7e4c50f39770b8c113df27c26681f0ee614621ae4d49bb300700d645',
      x86_64: 'cf1ff783f5cbd3232715b73d0907e39763c5412b75be5907cbb99b970f3deff2'
  })

  depends_on 'libtasn1'

  def self.build
    system './bootstrap'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-urandom=/dev/urandom"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end

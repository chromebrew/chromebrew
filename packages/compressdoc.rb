require 'package'

class Compressdoc < Package
  description 'Compress all man pages in a hierarchy and update symlinks. Supports a variety of compression algorithms.'
  homepage 'https://github.com/saltedcoffii/compressdoc/'
  version '20221119'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/saltedcoffii/compressdoc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/compressdoc/20221119_armv7l/compressdoc-20221119-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/compressdoc/20221119_armv7l/compressdoc-20221119-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/compressdoc/20221119_i686/compressdoc-20221119-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/compressdoc/20221119_x86_64/compressdoc-20221119-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '880427162c3107c72346778eeaee0d965321bd3f0cea87b6e496cc541aa76f5a',
     armv7l: '880427162c3107c72346778eeaee0d965321bd3f0cea87b6e496cc541aa76f5a',
       i686: '3712fc941fa77066d2ce378e2bafe67555ac5da2827a6f32338bd48b8a3bde8d',
     x86_64: '67cc750a7c59c35eaea3ddea7ff5c103d61c2c6f154b35416b0f85c7b3319674'
  })

  depends_on 'help2man' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} MANDIR=#{CREW_MAN_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end

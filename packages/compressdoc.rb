require 'package'

class Compressdoc < Package
  description 'Compress all man pages in a hierarchy and update symlinks. Supports a variety of compression algorithms.'
  homepage 'https://github.com/saltedcoffii/compressdoc/'
  @_ver = '20211031'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/saltedcoffii/compressdoc.git'
  git_hashtag 'v' + @_ver

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/compressdoc/20211031_armv7l/compressdoc-20211031-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/compressdoc/20211031_armv7l/compressdoc-20211031-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/compressdoc/20211031_i686/compressdoc-20211031-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/compressdoc/20211031_x86_64/compressdoc-20211031-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4540356220ea749beb260e45d25dcb3a6874691d723d3ba619213caae2b8c2a8',
     armv7l: '4540356220ea749beb260e45d25dcb3a6874691d723d3ba619213caae2b8c2a8',
       i686: 'ad99eb9bd25eaecbdcf2eef77bbe29b3326a31a984de27609c8f4a833c244aec',
     x86_64: '7ced0fd4fc946a5cfc1ea22821be18e23572228436736b7787cb1e86e9e202a0',
  })

  depends_on 'help2man' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} MANDIR=#{CREW_MAN_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end

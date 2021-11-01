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

  depends_on 'help2man' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} MANDIR=#{CREW_MAN_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end

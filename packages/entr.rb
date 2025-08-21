require 'package'

class Entr < Package
  description 'Run arbitrary commands when files change'
  homepage 'https://eradman.com/entrproject/'
  version '5.7'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/eradman/entr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc219af7c71433e90fbd4d94386205188fff62731e7ad3e4ef13195533aa5da7',
     armv7l: 'fc219af7c71433e90fbd4d94386205188fff62731e7ad3e4ef13195533aa5da7',
       i686: '1bcccb6bb885cfef5742ef86e7899fb45e01aadab843295fa0df65f352499359',
     x86_64: '687b29d4ac0f1975eb0fc0401e6732d8007f6f81794eb90e515da13cd68a7af7'
  })

  depends_on 'glibc' # R

  def self.build
    system './configure' # Not an autotools script, despite appearances.
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

require 'package'

class Entr < Package
  description 'Run arbitrary commands when files change'
  homepage 'https://eradman.com/entrproject/'
  version '5.8'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/eradman/entr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53ae3ab1123a429789ab0bad3eb397805fb389a912f95d0fece345e39024046f',
     armv7l: '53ae3ab1123a429789ab0bad3eb397805fb389a912f95d0fece345e39024046f',
       i686: 'bebd1e8e021e67aa6744f86f2014aeb0cf4f9d2e8f68271590c92322c2599b61',
     x86_64: '9f341edb971b00389b2acdb0a1d21ccd2a523f0f1a78a9a0481e96244ff35133'
  })

  depends_on 'glibc' => :executable

  def self.build
    system './configure' # Not an autotools script, despite appearances.
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

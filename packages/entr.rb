require 'package'

class Entr < Package
  description 'Run arbitrary commands when files change'
  homepage 'https://eradman.com/entrproject/'
  version '5.9'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/eradman/entr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fac84c4be656b3b513f8e82ad1f4e86923e4aa7c3eb11cd4e9c623a334d68e72',
     armv7l: 'fac84c4be656b3b513f8e82ad1f4e86923e4aa7c3eb11cd4e9c623a334d68e72',
       i686: 'f2c844adfcf917c664bcf922db0824ec68fff0f552dbe5941b2c593a961fd448',
     x86_64: 'e44089c14ea7db74cfbf270adad063230bf06399c4c2e2c2657e9947e4da4eb2'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system './configure' # Not an autotools script, despite appearances.
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

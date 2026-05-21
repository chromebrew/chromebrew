require 'package'

class Forkstat < Package
  description 'Forkstat is a program that logs process fork(), exec() and exit() activity.'
  homepage 'https://github.com/ColinIanKing/forkstat'
  version '0.04.00'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/forkstat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdf4cbe56b0fa65d2cf1c92dc522b61b0058e4f49d02135925629d4dd7611b6f',
     armv7l: 'cdf4cbe56b0fa65d2cf1c92dc522b61b0058e4f49d02135925629d4dd7611b6f',
       i686: '52df63b015a31abfa53c2d469405ce39c10c52aad3baca72e8613d70f0b71ed1',
     x86_64: '9523f75c4619c290056ada9fc6c354fbd78c4bcb22c9d4cc1d06ca4265b25e54'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

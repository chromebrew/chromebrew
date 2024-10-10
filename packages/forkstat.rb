require 'package'

class Forkstat < Package
  description 'Forkstat is a program that logs process fork(), exec() and exit() activity.'
  homepage 'https://github.com/ColinIanKing/forkstat'
  version '0.03.02'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/forkstat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89644ea699962fb37b8cc6d03a7b91edb9bce2f1bd3db7e88c721d47753b315e',
     armv7l: '89644ea699962fb37b8cc6d03a7b91edb9bce2f1bd3db7e88c721d47753b315e',
       i686: 'b5c0cb350fd1e77dc8eda6333fc9be26f713bfe2048410901c1c22a7a5ea2353',
     x86_64: '35fe2345bd935fa003b2eef9689726d2b26d3884322702c1713f5988135ad183'
  })

  def self.patch
    downloader 'https://patch-diff.githubusercontent.com/raw/ColinIanKing/forkstat/pull/10.patch', '22d70a02a3529011c4e9fa2d11cef0037c4729ca661229254287a51c0e6ac0b6'
    system 'git apply 10.patch'
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

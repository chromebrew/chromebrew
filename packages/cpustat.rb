require 'package'

class Cpustat < Package
  description 'cpustat periodically dumps out the current CPU utilisation statistics of running processes.'
  homepage 'https://github.com/ColinIanKing/cpustat'
  version '0.03.00'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/cpustat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8a55c174fee28fc12a5a153836696fdfc7320f5fbc106095e0d18faccc7c58e',
     armv7l: 'd8a55c174fee28fc12a5a153836696fdfc7320f5fbc106095e0d18faccc7c58e',
       i686: '8e215c1064acc4bc8329f801d79aa96b7d8537596e6b91c12037c5782f5b3454',
     x86_64: '8e96b86281a64fe06adc42c18a8507f0e52ffba4368cd3acb96b4f428ad0bb0d'
  })

  depends_on 'ncurses' => :build

  def self.build
    system "sed -i 's,sbin,bin,' Makefile"
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s,$, -I#{CREW_PREFIX}/include/ncurses,' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

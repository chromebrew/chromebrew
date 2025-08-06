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
    aarch64: '8fb261e29e498988fa539ad17586ba55e75fd7eecc027113f7e0b4412b4ed691',
     armv7l: '8fb261e29e498988fa539ad17586ba55e75fd7eecc027113f7e0b4412b4ed691',
       i686: '5809962b1a3185a5e86e72e26e449bb423eccddb3efbdac86d3850771d522d37',
     x86_64: '72fb91253d4801ba95a3f35fa2b1848a0ef656b8e3d3720f4b6519a071495f66'
  })

  depends_on 'glibc' # R
  depends_on 'ncurses' # R  depends_on 'ncurses' => :build

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

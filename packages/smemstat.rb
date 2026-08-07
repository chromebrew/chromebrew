require 'buildsystems/autotools'

class Smemstat < Autotools
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'https://github.com/ColinIanKing/smemstat'
  version '0.02.10'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/smemstat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32de67cf01fa86ca7ac325ae46b1a23774bd080e939dd864e9b5b2d66d42db10',
     armv7l: '32de67cf01fa86ca7ac325ae46b1a23774bd080e939dd864e9b5b2d66d42db10',
       i686: '66452ce0828149c8af7ba5bdbaf805628c35463cd1aa470f00d7fc5d1a50ba69',
     x86_64: '441dcdd891898b730436d84a5454ea0bd8916c47c13920c621dc8548ba36f543'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  def self.patch
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system "sed -i '/^CFLAGS += -Wall/s/$/ -I\\/usr\\/local\\/include\\/ncurses/' Makefile"
  end

  autotools_skip_configure
end

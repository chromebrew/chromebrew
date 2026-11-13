require 'buildsystems/autotools'

class Smemstat < Autotools
  description 'Smemstat reports the physical memory usage taking into consideration shared memory.'
  homepage 'https://github.com/ColinIanKing/smemstat'
  version '0.02.13'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/smemstat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d4dc10ec2205c06a6e4b023fa6e090bda63d817b896cb09051b4af3f1da3039',
     armv7l: '2d4dc10ec2205c06a6e4b023fa6e090bda63d817b896cb09051b4af3f1da3039',
       i686: 'c025dc4972bd792c21497e137928fdc3876d0b9e0307066cefb95b25cf948ffa',
     x86_64: '5342afb13976feb65c1769172fd9fcca1a98b15c7c492c3796e0c911701fb3f2'
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

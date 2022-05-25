require 'package'

class Libptytty < Package
  description 'OS independent and secure pty/tty and utmp/wtmp/lastlog handling.'
  homepage 'http://software.schmorp.de/pkg/rxvt-unicode.html'
  version '2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://dist.schmorp.de/libptytty/libptytty-2.0.tar.gz'
  source_sha256 '8033ed3aadf28759660d4f11f2d7b030acf2a6890cb0f7926fb0cfa6739d31f7'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libptytty/2.0_armv7l/libptytty-2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libptytty/2.0_armv7l/libptytty-2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libptytty/2.0_i686/libptytty-2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libptytty/2.0_x86_64/libptytty-2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd3ec0975d61905992380ef3ffa8820ee680aac02234822aece6f59a00d24d54b',
     armv7l: 'd3ec0975d61905992380ef3ffa8820ee680aac02234822aece6f59a00d24d54b',
       i686: 'c211dafd960e7257990f5753424026ebe35ce26ad5164b3b3f213c73e63949e7',
     x86_64: '80120d3e5fd47dda88681dc20e5b2d92f2b88e93beff5e6777383f802fdb0847'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake #{CREW_CMAKE_OPTIONS} ../ -G Ninja"
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

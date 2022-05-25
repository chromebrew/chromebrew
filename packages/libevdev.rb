require 'package'

class Libevdev < Package
  description 'libevdev is a wrapper library for evdev devices.'
  homepage 'https://www.freedesktop.org/wiki/Software/libevdev'
  version '1.12.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/libevdev/libevdev-1.12.1.tar.xz'
  source_sha256 '1dbba41bc516d3ca7abc0da5b862efe3ea8a7018fa6e9b97ce9d39401b22426c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libevdev/1.12.1_armv7l/libevdev-1.12.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libevdev/1.12.1_armv7l/libevdev-1.12.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libevdev/1.12.1_i686/libevdev-1.12.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libevdev/1.12.1_x86_64/libevdev-1.12.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ef21c213c561863ccb9cea8a5b88501fdec31c094af3238bac482b3db7b4b053',
     armv7l: 'ef21c213c561863ccb9cea8a5b88501fdec31c094af3238bac482b3db7b4b053',
       i686: 'c950e9e171bb65513f22ed76a1195caa4706cde60397f4ba0e1d0c213e9edd99',
     x86_64: '175b179c49706e118bdb1da0dfa4d216271396eecf3bd289f0db6fc11f631a64'
  })

  depends_on 'check' => :build
  depends_on 'doxygen' => :build
  depends_on 'python3' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

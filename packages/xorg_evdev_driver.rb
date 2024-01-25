require 'package'

class Xorg_evdev_driver < Package
  description 'The Xorg Evdev Driver package contains a Generic Linux input driver for the Xorg X server. It handles keyboard, mouse, touchpads and wacom devices, though for touchpad and wacom advanced handling, additional drivers are required.'
  homepage 'https://www.x.org'
  version '2.10.5-1'
  compatibility 'all'
  license 'ISC and MIT'
  source_url 'https://www.x.org/pub/individual/driver/xf86-input-evdev-2.10.5.tar.bz2'
  source_sha256 '9edaa6205baf6d2922cc4db3d8e54a7e7773b5f733b0ae90f6be7725f983b70d'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'dbca7b5731cbdcd8022afadb06c3da88a06ee6370e94babbca4ff8fad004d6b4',
      armv7l: 'dbca7b5731cbdcd8022afadb06c3da88a06ee6370e94babbca4ff8fad004d6b4',
        i686: '049e4a727d883ed1b60fb291263b7c2206fa3ee495555d3ba466406a83a50b05',
      x86_64: '8137f1c083f29c3e8b642e8af1aa0c3f087e90f1a3fa22d604ad6640f8c64b18'
  })

  depends_on 'mtdev'
  depends_on 'libevdev'
  depends_on 'xorg_server' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end

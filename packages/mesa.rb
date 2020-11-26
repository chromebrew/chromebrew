require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.2.3'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.2.3.tar.xz'
  source_sha256 'ae1b240e11531df528d14dc214d2dc4d2b4f2e835c6230ba0b492b171eceb82b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8cfbb1baa36d8bad71f49d39c4fa995d7ec4941e6668b3e7a727c6637362410d',
     armv7l: '8cfbb1baa36d8bad71f49d39c4fa995d7ec4941e6668b3e7a727c6637362410d',
       i686: '898ca5162f3c58e0cc519330922cc25357ea2bbac613d6adddd0281527ed6509',
     x86_64: 'ac1191c03d56ff28f72bf46ec200988e232eb1888fa71a8dc97867497389efb6',
  })

  depends_on 'llvm' => :build
  depends_on 'elfutils'
  depends_on 'glslang'
  depends_on 'libdrm'
  depends_on 'libomxil_bellagio'
  depends_on 'libunwind'
  depends_on 'libvdpau'
  depends_on 'libxdamage'
  depends_on 'libxshmfence'
  depends_on 'libxv'
  depends_on 'libxvmc'
  depends_on 'libxxf86vm'
  depends_on 'valgrind'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland_protocols'
  depends_on 'zstd'

  def self.build
    system "pip3 uninstall -y Mako MarkupSafe || :"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako"
    
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"

    # Just use mostly defaults.
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

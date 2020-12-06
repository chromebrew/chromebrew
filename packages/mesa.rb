require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.3.0'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.3.0.tar.xz'
  source_sha256 '2999738e888731531cd62b27519fa37566cc0ea2cd7d4d97f46abaa3e949c630'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cce8cade434faa8ac5aeba8ff9d5c8a141fad2758cbec45b7932f735f7249c3b',
     armv7l: 'cce8cade434faa8ac5aeba8ff9d5c8a141fad2758cbec45b7932f735f7249c3b',
       i686: '6a727c773fcf12b7f9755451ee99620d13b7589a62684b370a1392f00006cd8f',
     x86_64: '0638cf75f48e08d9f86ebcec3f2374212c64ba2a621449a883e7816b85459657',
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
  depends_on 'lm_sensors'

  def self.build
    system "pip3 uninstall -y Mako MarkupSafe || :"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako"
    
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"

    # Just use mostly defaults.
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

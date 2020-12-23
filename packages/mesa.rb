require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.3.1'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.3.1.tar.xz'
  source_sha256 'af751b49bb2ab0264d58c31e73d869e80333de02b2d1becc93f1b28c67aa780f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a20d3a986e868759e7a8cf50176c66ed2f390c24458bb5ff11075feddf6702ce',
     armv7l: 'a20d3a986e868759e7a8cf50176c66ed2f390c24458bb5ff11075feddf6702ce',
       i686: 'c5ddb63a37d1690d2762667c298c3580588f26eac4774eceb961939b4549923f',
     x86_64: '4e367780f7e6602c36159f257b5ac2b835728ca6b8bdf5d1534ae8d09e387a11',
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
    system "pip3 install --no-warn-script-location --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako"
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

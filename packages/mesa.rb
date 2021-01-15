require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  @_ver = '20.3.3'
  version @_ver
  compatibility 'all'
  source_url "https://mesa.freedesktop.org/archive/mesa-#{@_ver}.tar.xz"
  source_sha256 'f74e212d4838e982a10c203ffa998817d1855c5cf448ae87b58f96edea61d156'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6831a61a10ae5ad851a1de731d49f26d9131afa94c2c41d4686c846b2b4a588b',
      armv7l: '6831a61a10ae5ad851a1de731d49f26d9131afa94c2c41d4686c846b2b4a588b',
        i686: 'f41ddb3e53293fc0432a5ce347c8555c0e63cf78a48620d55391d7fb0fd52de5',
      x86_64: '59d6d87f66a5ae4c1c540ad57e95d970d5ab691a73eefceffa59d27f798ed69f',
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

    # With llvm 11.1 b_asneeded=false appears to be needed to get lld to be used.
    #
    system "meson #{CREW_MESON_OPTIONS} \
    -Dc_link_args='-fuse-ld=lld' \
    -Dcpp_link_args='-fuse-ld=lld' \
    -Db_asneeded=false \
     builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

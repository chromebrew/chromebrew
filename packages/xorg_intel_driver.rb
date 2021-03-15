# following https://github.com/archlinux/svntogit-packages/blob/packages/xf86-video-intel/trunk/PKGBUILD

require 'package'

class Xorg_intel_driver < Package
  description 'The Xorg Intel Driver package contains the X.Org Video Driver for Intel integrated video chips including 8xx, 9xx, Gxx, Qxx, HD, Iris, and Iris Pro graphics processors.'
  homepage 'https://01.org/linuxgraphics/'
  @_commit = '31486f40f8e8f8923ca0799aea84b58799754564'
  version "2.99.917+916+g#{@_commit[0..8]}"
  compatibility 'x86_64'
  
  source_url "https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel/-/archive/#{@_commit}/xf86-video-intel-#{@_commit}.tar.gz"
  source_sha256 '7936e8ddc2f09f272584cc9e9a2d265e9ab435f645ccd12085cd56291fa70653'
  
  depends_on 'xorg_server'
  depends_on 'libxvmc' => :build

  def self.build
    # don't try to use meson, it may make your system run out of memory and reboot
    system './autogen.sh'
    system "env CFLAGS='-flto=auto -lXv' CXXFLAGS='-flto=auto -lXv' \
            LDFLAGS='-flto=auto -lXv' \
            ./configure \
            #{CREW_OPTIONS} \
            --libexecdir=#{CREW_LIB_PREFIX} \
            --with-default-dri=3"
    
    #system "env LDFLAGS='-lXv' \
    #        meson #{CREW_MESON_LTO_OPTIONS} \
    #        -Dwith-default-dri=3 \
    #        builddir"
    #
    #system 'meson configure builddir'
    #system "ninja -l #{CREW_NPROC.to_i/2} -C builddir"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    #system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

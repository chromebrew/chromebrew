require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'https://www.mono-project.com/'
  version '6.14.1'
  license 'MIT, LGPL-2.1, GPL-2, BSD-4, NPL-1.1, Ms-PL, GPL-3-with-linking-exception and IDPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.mono-project.com/sources/mono/mono-#{version}.tar.xz"
  source_sha256 'f88898a2c453f1040e74965adb6c2cdadb2d7f2dea6856fec82823846ea036d8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78cb6f2adb3dde24509316cc5e7e351a5ece0fbf2dbeae8d8b6c9f88a9381be9',
     armv7l: '78cb6f2adb3dde24509316cc5e7e351a5ece0fbf2dbeae8d8b6c9f88a9381be9',
     x86_64: '35ec73376194b71d40ab8e57e01bffb0ec29c43ac66be3a995b03e522abbf017'
  })

  depends_on 'bc'
  depends_on 'libgdiplus'
  depends_on 'imake' => :build

  def self.prebuild
    # Just build on a system or on a container booted from a kernel
    # with SYSVIPC=y set.
    # system 'if [ ! -f /proc/config.gz ]; then sudo modprobe configs -v; fi'
    # system 'cat /proc/config.gz | gunzip | grep SYSVIPC=y || false' # Mono build hangs without this feature enabled.
  end

  def self.patch
    system 'filefix'
  end

  def self.build
    system "env XMKMF=#{CREW_PREFIX}/bin/xmkmf \
      ./configure #{CREW_CONFIGURE_OPTIONS} \
      --disable-maintainer-mode \
      --enable-llvm \
      --enable-loadedllvm \
      --enable-system-aot \
      --enable-ninja \
      --with-x \
      --with-libgdiplus"
    system 'make || make' # Make might fail the first time. This is a known upstream bug.
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

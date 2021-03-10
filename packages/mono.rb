require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  @_ver = '6.12.0.122'
  version @_ver
  compatibility 'all'
  source_url "https://download.mono-project.com/sources/mono/mono-#{@_ver}.tar.xz"
  source_sha256 '29c277660fc5e7513107aee1cbf8c5057c9370a4cdfeda2fc781be6986d89d23'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.12.0.122-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.12.0.122-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.12.0.122-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.12.0.122-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '78cb6f2adb3dde24509316cc5e7e351a5ece0fbf2dbeae8d8b6c9f88a9381be9',
     armv7l: '78cb6f2adb3dde24509316cc5e7e351a5ece0fbf2dbeae8d8b6c9f88a9381be9',
       i686: '53e9e0e6b21dc469a1e70df8e15ee9755b384d5ae4e2c7bd8199d23e265c6004',
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
      ./configure #{CREW_OPTIONS} \
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

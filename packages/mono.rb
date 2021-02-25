require 'package'

class Mono < Package
  description 'Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.'
  homepage 'http://www.mono-project.com/'
  version '6.12.0.107'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/mono/mono-6.12.0.107.tar.xz'
  source_sha256 '61f3cd629f8e99371c6b47c1f8d96b8ac46d9e851b5531eef20cdf9ab60d2a5f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.12.0.107-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.12.0.107-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.12.0.107-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mono-6.12.0.107-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0a978da374a9ee65506283b67be2cbae8aa5ca4f52d2db776120b4efe7654d0d',
     armv7l: '0a978da374a9ee65506283b67be2cbae8aa5ca4f52d2db776120b4efe7654d0d',
       i686: 'f39118c36d3356e6ad3c934041821dd9d22a0d60200b4e67a4efb6f9dbb88a65',
     x86_64: '4b32a060c7bfefdb6d57f419df73b57ae39ff79ea1bb7fca5605c9db8aae9b92'
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

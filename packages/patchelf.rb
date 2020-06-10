require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.9'
  compatibility 'all'
  source_url 'http://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.bz2'
  source_sha256 'a0f65c1ba148890e9f2f7823f4bedf7ecad5417772f64f994004f59a39014f83'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '21d3cba32a4f062b3bcca3d707e010255d4d72271de51a30e516100b603f584f',
     armv7l: '21d3cba32a4f062b3bcca3d707e010255d4d72271de51a30e516100b603f584f',
       i686: '955d83ae8b1a20e3862a038a3d1c726337ff2398ced29183c6daa18d52cfde88',
     x86_64: '361e72c9da52a344671c2e7826de40c04688ba99c075a83ed62aaf3ba89bc082',
  })

  def self.build
    system "./configure", "prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

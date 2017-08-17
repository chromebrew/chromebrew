require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.9'
  source_url 'http://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.bz2'
  source_sha256 'a0f65c1ba148890e9f2f7823f4bedf7ecad5417772f64f994004f59a39014f83'

  def self.build
    system "./configure", "prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

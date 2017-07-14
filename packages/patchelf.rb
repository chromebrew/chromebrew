require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.8-2'
  source_url 'http://nixos.org/releases/patchelf/patchelf-0.8/patchelf-0.8.tar.bz2'
  source_sha256 'c99f84d124347340c36707089ec8f70530abd56e7827c54d506eb4cc097a17e7'

  def self.build
    system "./configure", "prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

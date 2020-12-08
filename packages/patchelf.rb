require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.12-f347'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf/archive/f34751b88bd07d7f44f5cd3200fb4122bf916c7e.zip'
  source_sha256 '5ed94d15c44c13c1fa6a78b2f5ca499e465fd9171e4a1daf194e8523c04a9339'


  def self.build
    system "./bootstrap.sh"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

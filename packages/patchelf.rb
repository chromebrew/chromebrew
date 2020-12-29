require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.12-f347'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf/archive/f34751b88bd07d7f44f5cd3200fb4122bf916c7e.zip'
  source_sha256 '5ed94d15c44c13c1fa6a78b2f5ca499e465fd9171e4a1daf194e8523c04a9339'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.12-f347-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.12-f347-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.12-f347-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.12-f347-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '034a54878ec827f1ccc3544da727351aad90a609850429e6005942722d68752a',
      armv7l: '034a54878ec827f1ccc3544da727351aad90a609850429e6005942722d68752a',
        i686: 'ff9e45a2bdd883de56a4098f10f2e0ea8d8006dcdbf0c1f928252be5d1b921ab',
      x86_64: '085b74a502d3e4cd4ab7977ecbc885c4b08e2dea395d6543f89def8f25e60541',
  })

  def self.build
    system "./bootstrap.sh"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

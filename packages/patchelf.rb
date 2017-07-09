require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.8-2'
  source_url 'http://nixos.org/releases/patchelf/patchelf-0.8/patchelf-0.8.tar.bz2'
  source_sha256 'c99f84d124347340c36707089ec8f70530abd56e7827c54d506eb4cc097a17e7'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/patchelf-0.8-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/patchelf-0.8-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/patchelf-0.8-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/patchelf-0.8-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a4293cf0db444ee887c38b5ae807ba156c4bd8de64d98f8896c79f0c002df8a4',
     armv7l: 'a4293cf0db444ee887c38b5ae807ba156c4bd8de64d98f8896c79f0c002df8a4',
       i686: 'f01c64f1fb967f08d0496c2fc0d3bf6ddb74b30c340e60f5dd4ebdaf997e4e07',
     x86_64: 'f863efa106759a14b8f3bd9d7ebaef3e0b37bd1d598a7642ad96c6a02bdb7379',
  })

  def self.build
    system "./configure", "prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

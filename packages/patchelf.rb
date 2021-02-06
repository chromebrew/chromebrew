require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.12-f347'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf/archive/f34751b88bd07d7f44f5cd3200fb4122bf916c7e.zip'
  source_sha256 '5ed94d15c44c13c1fa6a78b2f5ca499e465fd9171e4a1daf194e8523c04a9339'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.12-f347-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.12-f347-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.12-f347-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/patchelf-0.12-f347-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e2b7945b1a842076b60347516561d29af99bc450ef66732d41086bb15bc8374d',
     armv7l: 'e2b7945b1a842076b60347516561d29af99bc450ef66732d41086bb15bc8374d',
       i686: '9496ae8276c538a798adcbf86816dab573c7ded0e96cd9e678991d7bd5ae54fe',
     x86_64: 'c234ee6df670e7d1405ff57c607d529a0c9bed6815fd900a51059796620e1fdc'
  })

  def self.build
    system './bootstrap.sh'
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
             ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

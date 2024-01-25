require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.17.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     aarch64: 'd3b21500b8727dc9372dd42f21c24e346634cb4aa972fbc4653832c08cb9e64d',
      armv7l: 'd3b21500b8727dc9372dd42f21c24e346634cb4aa972fbc4653832c08cb9e64d',
        i686: '6175e787dee232ce9120e86dbb5b578c2662959f92ff8e51efb2efdd8d52d915',
      x86_64: 'ce1fc5eb4f3ba8bf99fab4f4c3b4c9ca2cd2a93c504c0ac0928318b8cdafaeab'
  })

  no_env_options

  def self.build
    system './bootstrap.sh'
    system "LDFLAGS='-flto=auto -static' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system "sed -i 's/-flto=auto -static//g' Makefile"
    system "sed -i 's/-flto=auto -static//g' tests/Makefile"
    Dir.chdir('tests') do
      system 'make clean'
    end
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

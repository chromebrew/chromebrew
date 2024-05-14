require 'buildsystems/autotools'

class Patchelf < Autotools
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.18.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
     aarch64: '56fbe54307a6a7db9933c8e4d7b2d3c92836afd7c1c67d036a7a40d19b5a85ef',
      armv7l: '56fbe54307a6a7db9933c8e4d7b2d3c92836afd7c1c67d036a7a40d19b5a85ef',
        i686: '3602b232577da2b67aba8ae9069995909d38e8fb0efca5db0909df44e24e7c9e',
      x86_64: 'a75cf598e6498555c867d1a462ef78a43f1fe8f9ca3a147f3aab33336ca90f78'
  })

  no_env_options

  pre_configure_options "LDFLAGS='-flto=auto -static' "

  def self.patch
    # Allocate PHT & SHT at the end of the *.elf file
    downloader 'https://github.com/NixOS/patchelf/pull/544.patch', 'dbb0a0626e933e7368aaa84536bdb9cf46d4d05565e7fb5a9643154ec70c8ba1'
    system 'patch -Np1 -i 544.patch'
  end

  def self.check
    system "sed -i 's/-flto=auto -static//g' Makefile"
    system "sed -i 's/-flto=auto -static//g' tests/Makefile"
    Dir.chdir('tests') do
      system 'make clean'
    end
    system 'make', 'check'
  end
end

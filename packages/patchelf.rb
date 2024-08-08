require 'buildsystems/autotools'

class Patchelf < Autotools
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://github.com/NixOS/patchelf'
  version '0.18.0-a0f5433'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag 'a0f54334df36770b335c051e540ba40afcbf8378'
  binary_compression 'tar.zst'

  binary_sha256({
     aarch64: '4f03e9e000bb49583d7127d54caef6ee29758693061d68d446487b6b45dba169',
      armv7l: '4f03e9e000bb49583d7127d54caef6ee29758693061d68d446487b6b45dba169',
        i686: '85047aedda730e0e8e4f4b3cee0b69837e9319f49ae62fdaa79ef7accc5d23b5',
      x86_64: '8f88e3483f8ce03b708e992dc2c0dacef893b6824f057606d996761aca603c9d'
  })

  no_env_options

  pre_configure_options "LDFLAGS='-flto=auto -static' "

  def self.patch
    # Allocate PHT & SHT at the end of the *.elf file
    downloader 'https://github.com/NixOS/patchelf/pull/544.diff', 'fc65c0e6bfc751a1ab91f5f87c86202834eb3b3c208c6bb1eef077e4572e4b9c'
    system 'patch -Np1 -i 544.diff'
    # Fix rename-dynamic-symbols.sh test
    downloader 'https://github.com/NixOS/patchelf/pull/547.diff', '478669b8749b38defe2b835c2ece1d1ff495da6f0a899c7ac8c00f92c5ec9b2d'
    system 'patch -Np1 -i 547.diff'
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

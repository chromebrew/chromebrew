require 'buildsystems/autotools'

class Patchelf < Autotools
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'https://github.com/NixOS/patchelf'
  version '0.18.0-523f401'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag '523f401584d9584e76c9c77004e7abeb9e6c4551'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f03e9e000bb49583d7127d54caef6ee29758693061d68d446487b6b45dba169',
     armv7l: '4f03e9e000bb49583d7127d54caef6ee29758693061d68d446487b6b45dba169',
       i686: '85047aedda730e0e8e4f4b3cee0b69837e9319f49ae62fdaa79ef7accc5d23b5',
     x86_64: '8f88e3483f8ce03b708e992dc2c0dacef893b6824f057606d996761aca603c9d'
  })

  no_env_options

  pre_configure_options "LDFLAGS='-flto=auto -static -fuse-ld=#{CREW_LINKER}' "

  def self.check
    system "sed -i 's/-flto=auto -static//g' Makefile"
    system "sed -i 's/-flto=auto -static//g' tests/Makefile"
    Dir.chdir('tests') do
      system 'make clean'
    end
    system 'make', 'check'
  end
end

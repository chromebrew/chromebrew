require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.13'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.13_armv7l/patchelf-0.13-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.13_armv7l/patchelf-0.13-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.13_i686/patchelf-0.13-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.13_x86_64/patchelf-0.13-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fc778c01628667394ad79f4873a2ec329a6aed20745688586be07a2dc7e62818',
     armv7l: 'fc778c01628667394ad79f4873a2ec329a6aed20745688586be07a2dc7e62818',
       i686: 'ac2ef0780f5d8a7fa98a8b37c8cae9ee84423220c000ea3c4613509679542851',
     x86_64: '451436f8744dea2f1cc33d2232a54b38d3ba6788cda1fd7d0bef6b3003d096c6'
  })

  def self.build
    system './bootstrap.sh'
    # Optimization flags from https://github.com/InBetweenNames/gentooLTO
    # Build static for use in case needed with glibc brokenness.
    system "env CFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
    CXXFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
    LDFLAGS='-flto=auto -static' \
             ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.12-PR278'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag 'f376fe61bae57e9e50f4622f5a44febb4f5bfd3c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.12-PR278_armv7l/patchelf-0.12-PR278-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.12-PR278_armv7l/patchelf-0.12-PR278-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.12-PR278_i686/patchelf-0.12-PR278-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.12-PR278_x86_64/patchelf-0.12-PR278-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '61fc1bd2289cb16b9437c7f2445227d94caee84c7f620311299b48451f6ea9c3',
     armv7l: '61fc1bd2289cb16b9437c7f2445227d94caee84c7f620311299b48451f6ea9c3',
       i686: 'f2998b08da471c4a876a3132b87134da6aae53f7dbdcb286e649a389dd7453fb',
     x86_64: 'ac8031d033df7019916b7fc866b08c1c0c9aeca668946521749ad44c5c0a3d63'
  })

  depends_on 'hashpipe' => :build

  def self.patch
    # This pulls in a patch from https://github.com/NixOS/patchelf/pull/278
    # which implements a fix for the program header corruption
    # addressed in https://github.com/NixOS/patchelf/pull/243
    system 'curl -Ls https://patch-diff.githubusercontent.com/raw/NixOS/patchelf/pull/278.patch | \
    hashpipe sha256 0c80997462ab541ea3694a8e988f4f008e40f887b933883e312ff9acb3605fa5 | \
    patch -Np1 --binary'
  end

  def self.build
    system './bootstrap.sh'
    # Optimization flags from https://github.com/InBetweenNames/gentooLTO
    # Build static for use in case needed with glibc brokenness.
    system "env  CFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
    CXXFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
    LDFLAGS='-flto=auto -static' \
             ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

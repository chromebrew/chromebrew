require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.14.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.14.3_armv7l/patchelf-0.14.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.14.3_armv7l/patchelf-0.14.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.14.3_i686/patchelf-0.14.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.14.3_x86_64/patchelf-0.14.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '76cf82fea05e417739a96bd96b0468be749d4dc2ed7edcfff73ee48fd2ed1130',
     armv7l: '76cf82fea05e417739a96bd96b0468be749d4dc2ed7edcfff73ee48fd2ed1130',
       i686: '41389fd3670f713ee2b085560071155ff99c453fc80c222fc26354ab6a840c04',
     x86_64: '0f15080a932a654e0861f45145e9e76927f07db9cf3a032ad837426d95bb6a68'
  })

  def self.build
    system './bootstrap.sh'
    system "LDFLAGS='-flto=auto -static' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

require 'package'

class Patchelf < Package
  description 'PatchELF is a small utility to modify the dynamic linker and RPATH of ELF executables.'
  homepage 'http://nixos.org/patchelf.html'
  version '0.14.5'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/NixOS/patchelf.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.14.5_armv7l/patchelf-0.14.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.14.5_armv7l/patchelf-0.14.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.14.5_i686/patchelf-0.14.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/patchelf/0.14.5_x86_64/patchelf-0.14.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '81227e2a9b1de212fb041bc7dffd6282f844182e4c39ea6fb6e50084561929f0',
     armv7l: '81227e2a9b1de212fb041bc7dffd6282f844182e4c39ea6fb6e50084561929f0',
       i686: 'db817f6eff4c97d07b1849c634dc82087ad584e486d154fd2a0bc02072ec923f',
     x86_64: '9bc6661f27094ce4033eadc302c042d923b9c0a544f959d1359cfc767971a9b6'
  })

  git_hashtag version
  no_env_options

  def self.build
    system './bootstrap.sh'
    system "CFLAGS='-fuse-ld=gold' LDFLAGS='-flto=auto -static' ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

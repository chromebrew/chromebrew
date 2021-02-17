require 'package'

class Bubblewrap < Package
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  @_ver = '0.4.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/containers/bubblewrap/releases/download/v#{@_ver}/bubblewrap-#{@_ver}.tar.xz"
  source_sha256 'b9c69b9b1c61a608f34325c8e1a495229bacf6e4a07cbb0c80cf7a814d7ccc03'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'a7a003bbb434206346b0e5cf068e0d2cf6231dcafd47c2d4774e0514b04d26d4',
      armv7l: 'a7a003bbb434206346b0e5cf068e0d2cf6231dcafd47c2d4774e0514b04d26d4',
        i686: '32bcaff9feccd26cf1379212ea8050d99a271a4e097923aab48638d29d0aef90',
      x86_64: '30b1458d68567c43b23251167a3488b7b05f7542b4b8b5d0278b026646e01d24',
  })


  depends_on 'libcap' => :build

  def self.patch
    system "sed -i '/SUDO_BIN/d' Makefile.in"
  end

  def self.build
    system './configure --help'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure \
      --disable-maintainer-mode \
      --disable-man \
      --with-priv-mode=none \
      --enable-sudo"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/bwrap", "#{CREW_DEST_PREFIX}/bin/bwrap.elf", mode: 0o755
    @bwrap_sh = <<~BWRAP_HEREDOC
      #!/bin/bash
      sudo setcap cap_sys_admin+eip "#{CREW_PREFIX}/bin/bwrap.elf"
      sudo -E  "#{CREW_PREFIX}/bin/bwrap.elf" -- "\$*"
    BWRAP_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/bin/bwrap", @bwrap_sh, perm: 0o755)
  end
end

require 'package'

class Bubblewrap < Package
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  @_ver = '0.4.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/containers/bubblewrap/releases/download/v#{@_ver}/bubblewrap-#{@_ver}.tar.xz"
  source_sha256 'b9c69b9b1c61a608f34325c8e1a495229bacf6e4a07cbb0c80cf7a814d7ccc03'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bubblewrap-0.4.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5bb3cca606a888b7881821eeff96aa28408cb820a6acf1ad788ede5b3ded6fce',
     armv7l: '5bb3cca606a888b7881821eeff96aa28408cb820a6acf1ad788ede5b3ded6fce',
       i686: '071ccd273b04892dc2a633784b6cdb04edded34f9f664bf09d3b2b8228a023d5',
     x86_64: '1fda7e2d705a6f9ef55d2158de6c172d4d78e562566b0a8177d269b3c6df520e'
  })

  depends_on 'libcap' => :build
  depends_on 'dconf'

  def self.patch
    system "sed -i '/SUDO_BIN/d' Makefile.in"
  end

  def self.build
    system './configure --help'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure \
      --disable-maintainer-mode \
      --disable-man \
      --with-priv-mode=setuid \
      --enable-sudo"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/bwrap", "#{CREW_DEST_PREFIX}/bin/bwrap.elf", mode: 0o755
    @bwrap_sh = <<~BWRAP_HEREDOC
      #!/bin/bash
      sudo chown root "#{CREW_PREFIX}/bin/bwrap.elf"
      sudo chmod +s "#{CREW_PREFIX}/bin/bwrap.elf"
      #{CREW_PREFIX}/bin/bwrap.elf "\$@"
      sudo chown chronos "#{CREW_PREFIX}/bin/bwrap.elf"
    BWRAP_HEREDOC
    IO.write("#{CREW_DEST_PREFIX}/bin/bwrap", @bwrap_sh, perm: 0o755)
  end
end

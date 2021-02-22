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
    aarch64: '7c3f2c4a332342b9d7aa15d6aa776a38d1dc94a8c4c904a81a64f7e7ca45cedd',
     armv7l: '7c3f2c4a332342b9d7aa15d6aa776a38d1dc94a8c4c904a81a64f7e7ca45cedd',
       i686: '75795e2c15720ad488335de59b94c3577102b8ba3ca5e855b5b132f3f213cce7',
     x86_64: '4c3f0aaec3afc4a1ba48d10dfb87208b47d11f2047fe11d6dce5056ff4dce79f'
  })

  depends_on 'libcap' => :build
  depends_on 'dconf'

  def self.patch
    system "sed -i '/SUDO_BIN/d' Makefile.in"
  end

  def self.build
    system './configure --help'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
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

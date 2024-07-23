require 'package'

class Bubblewrap < Package
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  version '0.8.0'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://github.com/containers/bubblewrap/releases/download/v#{version}/bubblewrap-#{version}.tar.xz"
  source_sha256 '957ad1149db9033db88e988b12bcebe349a445e1efc8a9b59ad2939a113d333a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '03ab623c12a28cb7267dc25efffb286dafde5b566f890eb1f86d52f9a3411b3a',
     armv7l: '03ab623c12a28cb7267dc25efffb286dafde5b566f890eb1f86d52f9a3411b3a',
       i686: '33e1a0850f79cb2b4e9e5e4f4d81b51931ec18be2147878431ab943a2f54ea1d',
     x86_64: 'af31e6097168fc0219300ca90d2f68f13382c6469130a7417f88d53bca47201c'
  })

  depends_on 'dconf' => :build
  depends_on 'glibc' # R
  depends_on 'libcap' # R

  def self.patch
    system "sed -i '/SUDO_BIN/d' Makefile.in"
  end

  def self.build
    system './configure --help'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --with-priv-mode=setuid \
      --enable-sudo"
    system 'make'
    File.write 'bwrap.sh', <<~BWRAP_HEREDOC
      #!/bin/bash
      sudo chown root "#{CREW_PREFIX}/bin/bwrap.elf"
      sudo chmod +s "#{CREW_PREFIX}/bin/bwrap.elf"
      #{CREW_PREFIX}/bin/bwrap.elf "$@"
      sudo chown chronos "#{CREW_PREFIX}/bin/bwrap.elf"
    BWRAP_HEREDOC
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install "#{CREW_DEST_PREFIX}/bin/bwrap", "#{CREW_DEST_PREFIX}/bin/bwrap.elf", mode: 0o755
    FileUtils.install 'bwrap.sh', "#{CREW_DEST_PREFIX}/bin/bwrap", mode: 0o755
  end
end

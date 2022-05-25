require 'package'

class Snort < Package
  description 'Snort is an open source intrusion prevention system capable of real-time traffic analysis and packet logging.'
  homepage 'https://www.snort.org/'
  version '2.9.20'
  license 'GPL-2'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://www.snort.org/downloads/snort/snort-2.9.20.tar.gz'
  source_sha256 '29400e13f53b1831e0b8b10ec1224a1cbaa6dc1533a5322a20dd80bb84b4981c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/snort/2.9.20_armv7l/snort-2.9.20-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/snort/2.9.20_armv7l/snort-2.9.20-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/snort/2.9.20_x86_64/snort-2.9.20-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'abe8b0488c8e15c2f21e28749be32ac981e21bac0df0eba64633c3599f4b39e2',
     armv7l: 'abe8b0488c8e15c2f21e28749be32ac981e21bac0df0eba64633c3599f4b39e2',
     x86_64: 'c5442cbeef2caaf47c3c3166768bae521e8438b7919431c9fd2d37a1059c3705'
  })

  depends_on 'daq'
  depends_on 'libdnet'
  depends_on 'libtirpc'
  depends_on 'luajit'
  depends_on 'pcre'

  no_fhs

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-sourcefire \
            --with-dnet-includes=#{CREW_PREFIX}/include/dnet \
            --with-tirpc-includes=#{CREW_PREFIX}/include/tirpc"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

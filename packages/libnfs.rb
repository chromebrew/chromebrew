require 'package'

class Libnfs < Package
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  @_ver = '4.0.0'
  version "#{@_ver}-1"
  compatibility 'all'
  license 'GPL-3, LGPL-2.1 and BSD'
  source_url 'https://github.com/sahlberg/libnfs.git'
  git_hashtag "libnfs-#{@_ver}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '93c8332ed7a11e62196a451206a1bb01f5c8d1bba0c860fdf08a6ee52638748f',
      armv7l: '93c8332ed7a11e62196a451206a1bb01f5c8d1bba0c860fdf08a6ee52638748f',
        i686: 'd838e8f83938d1621884496bcc226b33c61b5d20a1c45496d98733cde4c2505c',
      x86_64: '8ff8bdbe19ee2c2bafe7ca410729eb30fc1195de1c3cab48867375752ad59299'
  })

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --enable-utils"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end

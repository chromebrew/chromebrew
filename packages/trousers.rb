require 'package'

class Trousers < Package
  description 'The open-source TCG Software Stack.'
  homepage 'http://trousers.sourceforge.net/'
  @_ver = '0.3.15'
  version "#{@_ver}-2"
  license 'CPL-1.0 and GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/trousers/trousers/#{@_ver}/trousers-#{@_ver}.tar.gz"
  source_sha256 '1e5be93e518372acf1d92d2f567d01a46fdb0b730487e544e6fb896c59cac77f'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/trousers/0.3.15-2_armv7l/trousers-0.3.15-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/trousers/0.3.15-2_armv7l/trousers-0.3.15-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/trousers/0.3.15-2_i686/trousers-0.3.15-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/trousers/0.3.15-2_x86_64/trousers-0.3.15-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '17010e0e4cdc72fb91eebab4a8e9b549af1f53d7dd46ddcb4c080cd83bfb6082',
     armv7l: '17010e0e4cdc72fb91eebab4a8e9b549af1f53d7dd46ddcb4c080cd83bfb6082',
       i686: 'cc723134d4817400e656861b72adb6c9ec51df428cc7d798463b8c3a94f3f52f',
     x86_64: '195bca093e6085636b522970c9244054fec6b0474ab717ac3106bef2577240d1'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R

  def self.build
    system './bootstrap.sh'
    system "mold -run ./configure \
      #{CREW_OPTIONS} \
      --with-gui=none"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end

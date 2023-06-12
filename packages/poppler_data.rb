require 'package'

class Poppler_data < Package
  description 'This additional package consists of encoding files for use with Poppler.'
  homepage 'https://poppler.freedesktop.org/'
  @_ver = '0.4.12'
  version @_ver
  license 'BSD, GPL-2 and MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://poppler.freedesktop.org/poppler-data-#{@_ver}.tar.gz"
  source_sha256 'c835b640a40ce357e1b83666aabd95edffa24ddddd49b8daff63adb851cdab74'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler_data/0.4.12_armv7l/poppler_data-0.4.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler_data/0.4.12_armv7l/poppler_data-0.4.12-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/poppler_data/0.4.12_x86_64/poppler_data-0.4.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ec1bcb5fb7d23cc28bbe77b3436beefff248f1164cf5910dec031f54d87820f8',
     armv7l: 'ec1bcb5fb7d23cc28bbe77b3436beefff248f1164cf5910dec031f54d87820f8',
     x86_64: '7dbd6d124bc6b484d35b1692e74183e6fffaa0eeddab99b843a64d563bd95a8b'
  })

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end

require 'package'

class Poppler_data < Package
  description 'This additional package consists of encoding files for use with Poppler.'
  homepage 'https://poppler.freedesktop.org/'
  version '0.4.12'
  license 'BSD, GPL-2 and MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://poppler.freedesktop.org/poppler-data-#{version}.tar.gz"
  source_sha256 'c835b640a40ce357e1b83666aabd95edffa24ddddd49b8daff63adb851cdab74'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec1bcb5fb7d23cc28bbe77b3436beefff248f1164cf5910dec031f54d87820f8',
     armv7l: 'ec1bcb5fb7d23cc28bbe77b3436beefff248f1164cf5910dec031f54d87820f8',
     x86_64: '7dbd6d124bc6b484d35b1692e74183e6fffaa0eeddab99b843a64d563bd95a8b'
  })

  def self.install
    system "make PREFIX=#{CREW_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end

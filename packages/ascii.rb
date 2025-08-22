require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.30'
  license 'BSD'
  compatibility 'all'
  source_url "http://www.catb.org/~esr/ascii/ascii-#{version}.tar.gz"
  source_sha256 '728422d5f4da61a37a17b4364d06708e543297de0a5f70305243236d80df072d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8566ece437dabf1e626c61ec2033ae2f095ef1e867c44b5502d33204adb24007',
     armv7l: '8566ece437dabf1e626c61ec2033ae2f095ef1e867c44b5502d33204adb24007',
       i686: '60357de2943caef872b9baf79a80026adfd9ff6ae2f5939fb0973efd457540d2',
     x86_64: '1b49f74a7def6f7fbbff90f8315378b78b43d91275684745bb0aa53f8b31e723'
  })

  depends_on 'glibc' # R

  def self.build
    system 'make'
  end

  def self.install
    system 'gzip -9 ascii.1'
    system "install -Dm755 ascii #{CREW_DEST_PREFIX}/bin/ascii"
    system "install -Dm644 ascii.1.gz #{CREW_DEST_PREFIX}/man/man1/ascii.1.gz"
  end
end

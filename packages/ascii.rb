require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.30'
  license 'BSD'
  compatibility 'all'
  source_url 'http://www.catb.org/~esr/ascii/ascii-3.18.tar.gz'
  source_sha256 '728422d5f4da61a37a17b4364d06708e543297de0a5f70305243236d80df072d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8ee6c91094269253d7f55c9ccf3caa32c53e52cf9f97432b813a445310a5e3f',
     armv7l: 'a8ee6c91094269253d7f55c9ccf3caa32c53e52cf9f97432b813a445310a5e3f',
       i686: 'ff9a6e2e0fb331e62c563a8ad35d907acca601c62ce2ec16f41c15bdf88fb097',
     x86_64: 'fdb9705e9562dce107a4660e3b777cdff5773080878b93f654c3a68d46d25493'
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

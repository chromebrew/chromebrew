require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.33'
  license 'BSD'
  compatibility 'all'
  source_url "http://www.catb.org/~esr/ascii/ascii-#{version}.tar.gz"
  source_sha256 'fbfc0abf8d0629ff1cf204b916c45ede436259497cff8461f85ebceccde356fd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23f2ff524d83a11d5b44cf5f01a953ca65e0d26ba2e7132b9e261fb769d74480',
     armv7l: '23f2ff524d83a11d5b44cf5f01a953ca65e0d26ba2e7132b9e261fb769d74480',
       i686: 'e94f837faaed6f54f9abf31e7ddecd1bd29b086eadeb611cf1cbc3849a02bb96',
     x86_64: '55275748e7d03b3629559f69bf61c0b4f07887cf4c5b0e108e7e17bab1db8ca6'
  })

  depends_on 'asciidoctor' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'ascii', "#{CREW_DEST_PREFIX}/bin/ascii", mode: 0o755
    FileUtils.install 'ascii.1', "#{CREW_DEST_MAN_PREFIX}/man1/ascii.1", mode: 0o644
  end
end

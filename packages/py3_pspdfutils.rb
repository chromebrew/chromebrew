require 'buildsystems/pip'

class Py3_pspdfutils < Pip
  description 'Utilities for manipulating PostScript documents.'
  homepage 'https://github.com/rrthomas/psutils'
  version '3.3.5-py3.12'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd49b9298213e4e7b58a2440e9000271d121618ff9e0e533b00e10af4e5c333f',
     armv7l: 'bd49b9298213e4e7b58a2440e9000271d121618ff9e0e533b00e10af4e5c333f',
       i686: '9d75efea696f536961603af489e01d48399d289bfe1a86a0bcc6a8a3c7e6822e',
     x86_64: 'ef9e35e1a74ee2c5c7794c2c093f9bbc987c08f06d22774306ae9240dedb1974'
  })

  depends_on 'libpaper'

  no_source_build
end

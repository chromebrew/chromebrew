require 'buildsystems/autotools'

class Mate_common < Autotools
  description 'Common files for development of MATE packages.'
  homepage 'https://mate-desktop.org'
  version '1.28.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pub.mate-desktop.org/releases/#{version.rpartition('.')[0]}/mate-common-#{version}.tar.xz"
  source_sha256 '42b7c2cee268f71d7e1c1ad4f69bcda0ecd65578a96722187c6b76378d26ba0a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '46f72638edbadae87ade3a037718e38dd5717b458d8f229e350618c9cc0a7a4a',
     armv7l: '46f72638edbadae87ade3a037718e38dd5717b458d8f229e350618c9cc0a7a4a',
     x86_64: 'c08dcd0b4f1a7167ff2e4ed81a7d6d6374bfc38eba356e920c5c0b89992c41e6'
  })

  depends_on 'gtk_doc'
end

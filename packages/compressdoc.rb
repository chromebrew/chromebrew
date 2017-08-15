require 'package'

class Compressdoc < Package
  description 'Compress (with bzip2 or gzip) all man pages in a hierarchy and update symlinks'
  homepage 'https://github.com/ojab/BLFS/blob/master/auxfiles/compressdoc'
  version '9b2b12'
  source_url 'https://github.com/ojab/BLFS/archive/9b2b12c0d809e287e1ea3fa4790a73a71feffbe4.tar.gz'
  source_sha256 '6ebe4a9bbef5d0e84a36e56ac6fb1f0a2cfa86cb00c49628a0d3151d37f5d2f1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/compressdoc-9b2b12-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/compressdoc-9b2b12-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/compressdoc-9b2b12-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/compressdoc-9b2b12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b3af093343c2651168f28aea8dc4ac36709b2c13c0b6430553762580b0330ccd',
     armv7l: 'b3af093343c2651168f28aea8dc4ac36709b2c13c0b6430553762580b0330ccd',
       i686: '88addb581c6c8b6764d896097d412ff805fdc646a8a801f6246db9ced322a4e1',
     x86_64: 'f2eebdff47e0e6758ab1bf504577ea2d4513a2cbfb768b12439624db73e5fbaf',
  })

  def self.install
    system "chmod +x auxfiles/compressdoc"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp auxfiles/compressdoc #{CREW_DEST_DIR}/usr/local/bin"
  end
end

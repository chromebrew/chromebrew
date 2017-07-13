require 'package'

class Compressdoc < Package
  description 'Compress (with bzip2 or gzip) all man pages in a hierarchy and update symlinks'
  homepage 'https://github.com/ojab/BLFS/blob/master/auxfiles/compressdoc'
  version '9b2b12'
  source_url 'https://github.com/ojab/BLFS/archive/9b2b12c0d809e287e1ea3fa4790a73a71feffbe4.tar.gz'
  source_sha256 '6ebe4a9bbef5d0e84a36e56ac6fb1f0a2cfa86cb00c49628a0d3151d37f5d2f1'
  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/binaries/compressdoc-9b2b12-chromeos-x86_64.tar.xz',
    armv7l:  'https://github.com/jam7/chromebrew/releases/download/binaries/compressdoc-9b2b12-chromeos-x86_64.tar.xz',
    i686:    'https://github.com/jam7/chromebrew/releases/download/binaries/compressdoc-9b2b12-chromeos-x86_64.tar.xz',
    x86_64:  'https://github.com/jam7/chromebrew/releases/download/binaries/compressdoc-9b2b12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4743bfb71bf851cb659dce71465e034fae19250e72f97aa7a50d6d8298f03347',
    armv7l:  '4743bfb71bf851cb659dce71465e034fae19250e72f97aa7a50d6d8298f03347',
    i686:    '4743bfb71bf851cb659dce71465e034fae19250e72f97aa7a50d6d8298f03347',
    x86_64:  '4743bfb71bf851cb659dce71465e034fae19250e72f97aa7a50d6d8298f03347',
  })

  def self.install
    system "chmod +x auxfiles/compressdoc"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp auxfiles/compressdoc #{CREW_DEST_DIR}/usr/local/bin"
  end
end

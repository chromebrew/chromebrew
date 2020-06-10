require 'package'

class Compressdoc < Package
  description 'Compress (with bzip2 or gzip) all man pages in a hierarchy and update symlinks'
  homepage 'https://github.com/ojab/BLFS/blob/master/auxfiles/compressdoc'
  version '20080421.1623'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/ojab/BLFS/af6c11d985fe36c8828abaa9d5124c8725580b15/auxfiles/compressdoc'
  source_sha256 'f380473baaa8785b1c7a7a30f2dda4b748a9baed3b335655faedad49ebf8246b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/compressdoc-20080421.1623-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/compressdoc-20080421.1623-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/compressdoc-20080421.1623-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/compressdoc-20080421.1623-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3e63d392982f5ccfd330f927febec36b18a53ad722b26a4beb2f4de3efad6c94',
     armv7l: '3e63d392982f5ccfd330f927febec36b18a53ad722b26a4beb2f4de3efad6c94',
       i686: '9ec4c600cdbff22fe39a719b28fda93ffa78b9517ef930091ff05c486b72123f',
     x86_64: 'ff47516fe18e91d4e1a255b4a78f336a0cba0dd06c8ee6c4aa3b45e1c9ea8ec8',
  })

  def self.install
    system "install -Dm755 ../compressdoc #{CREW_DEST_PREFIX}/bin/compressdoc"
  end
end

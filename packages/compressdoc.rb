require 'package'

class Compressdoc < Package
  description 'Compress (with bzip2 or gzip) all man pages in a hierarchy and update symlinks'
  homepage 'https://github.com/ojab/BLFS/blob/master/auxfiles/compressdoc'
  version '20080421.1623'
  source_url 'https://raw.githubusercontent.com/ojab/BLFS/af6c11d985fe36c8828abaa9d5124c8725580b15/auxfiles/compressdoc'
  source_sha256 'f380473baaa8785b1c7a7a30f2dda4b748a9baed3b335655faedad49ebf8246b'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 ../compressdoc #{CREW_DEST_PREFIX}/bin/compressdoc"
  end
end

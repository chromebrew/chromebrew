require 'package'

class Compressdoc < Package
  description 'Compress (with bzip2 or gzip) all man pages in a hierarchy and update symlinks'
  homepage 'https://github.com/ojab/BLFS/blob/master/auxfiles/compressdoc'
  version '9b2b12'
  source_url 'https://github.com/ojab/BLFS/archive/9b2b12c0d809e287e1ea3fa4790a73a71feffbe4.zip'
  source_sha1 'dd55e750128972ffd1022808b1b26cff2de242b1'

  depends_on 'unzip'

  def self.install
    system "chmod +x auxfiles/compressdoc"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp auxfiles/compressdoc #{CREW_DEST_DIR}/usr/local/bin"
  end
end

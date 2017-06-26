require 'package'

class Compressdoc < Package
  description 'Compress (with bzip2 or gzip) all man pages in a hierarchy and update symlinks'
  homepage 'https://github.com/ojab/BLFS/blob/master/auxfiles/compressdoc'
  version '8.0'
  source_url 'https://github.com/ojab/BLFS/archive/8.0.tar.gz'
  source_sha1 '1a4bcb8bd771701e91d9d525d8348dd6ec1c7db8'

  def self.install
    system "wget https://raw.githubusercontent.com/ojab/BLFS/master/auxfiles/compressdoc"
    abort "Checksum mismatch. :/ Try again.".lightred unless Digest::SHA1.hexdigest( File.read("compressdoc") ) == "3d853b92a1e0495c3b2e753e415c6fffb277d44a"
    system "chmod +x compressdoc"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp compressdoc #{CREW_DEST_DIR}/usr/local/bin"
  end
end

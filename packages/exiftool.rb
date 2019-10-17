require 'package'

class Exiftool < Package
  description 'ExifTool is a platform-independent Perl library plus a command-line application for reading, writing and editing meta information in a wide variety of files.'
  homepage 'https://owl.phy.queensu.ca/~phil/exiftool/'
  version '11.71'
  source_url 'https://owl.phy.queensu.ca/~phil/exiftool/Image-ExifTool-11.71.tar.gz'
  source_sha256 '5258817bea57e0eb76d6783acb387f01bb5212ecb27e9db722f3e7f16cf0b5b5'

  binary_url ({
  })
  binary_sha256 ({
  })

  @arch = 'x64'

  depends_on 'perl'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/exiftool"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/exiftool"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "echo 'env perl \'#{CREW_PREFIX}/share/exiftool/exiftool\'' > '#{CREW_DEST_PREFIX}/bin/exiftool'"
    FileUtils.chmod "+x", "#{CREW_DEST_PREFIX}/bin/exiftool"
  end

end


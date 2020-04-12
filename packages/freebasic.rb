require 'package'

class Freebasic < Package
  description 'FreeBASIC is a free/open source (GPL), BASIC compiler for Microsoft Windows, DOS and Linux.'
  homepage 'https://www.freebasic.net/'
  version '1.07.1-1'
  case ARCH
  when 'i686'
    source_url 'https://downloads.sourceforge.net/project/fbc/Binaries%20-%20Linux/FreeBASIC-1.07.1-linux-x86.tar.gz'
    source_sha256 'a5b8f31e38a214d63a3d8e0b1ac6608f6a304891e40a3c0755940cba2f8401f1'
  when 'x86_64'
    source_url 'https://downloads.sourceforge.net/project/fbc/Binaries%20-%20Linux/FreeBASIC-1.07.1-linux-x86_64.tar.gz'
    source_sha256 'd5034e81201760de7fd7bc563d8c33213a9530da3d15d4907e52d47278a00243'
  end

  depends_on 'libtinfo'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    system "./install.sh -i #{CREW_DEST_PREFIX}"
    FileUtils.mv "#{CREW_DEST_PREFIX}/man", "#{CREW_DEST_PREFIX}/share"
  end
end

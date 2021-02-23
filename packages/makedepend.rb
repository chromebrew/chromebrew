require 'package'

class Makedepend < Package
  description 'Makedepend parses C sources in Makefiles to generate dependency lists'
  homepage 'https://x.org'
  version '1.0.6'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/makedepend-1.0.6.tar.gz'
  source_sha256 '845f6708fc850bf53f5b1d0fb4352c4feab3949f140b26f71b22faba354c3365'

  depends_on 'libx11'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
              --without-lint"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

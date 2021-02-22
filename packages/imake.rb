require 'package'

class Imake < Package
  description 'A build automation system written for the X Window System.'
  homepage 'https://x.org'
  version '1.0.8'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/imake-1.0.8.tar.gz'
  source_sha256 '8178a09bfef33ad5f61cb5cb62283df7d3a5682f014507d2e7cfd922485a5c00'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imake-1.0.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imake-1.0.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imake-1.0.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imake-1.0.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b990112a38f374af2bb69f84201c4c3234075e3ba5c3f91d5af4fe1660edf5af',
     armv7l: 'b990112a38f374af2bb69f84201c4c3234075e3ba5c3f91d5af4fe1660edf5af',
       i686: '3068b234517cb02e3e246554f4c390ad0fe72bf11535878094ae791e55ef584b',
     x86_64: '1cef5aab03fa1906200b88b87d31be2d48e1a3b71d47b779fd4e53ea2a4bf3ee',
  })

  depends_on 'xorg_cf_files'
  depends_on 'gccmakedep'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

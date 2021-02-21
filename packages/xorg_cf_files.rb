require 'package'

class Xorg_cf_files < Package
  description 'X.org cf files for use with imake builds.'
  homepage 'https://x.org'
  version '1.0.6'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/xorg-cf-files-1.0.6.tar.gz'
  source_sha256 '6d56094e5d1a6c7d7a9576ac3a0fc2c042344509ea900d59f4b23df668b96c7a'

  depends_on 'font_util'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

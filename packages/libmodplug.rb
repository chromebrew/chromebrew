require 'package'

class Libmodplug < Package
  description 'A MOD playing library'
  homepage 'http://modplug-xmms.sourceforge.net/'
  version '0.8.9.0-1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/modplug-xmms/libmodplug-0.8.9.0.tar.gz'
  source_sha256 '457ca5a6c179656d66c01505c0d95fafaead4329b9dbaa0f997d00a3508ad9de'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end

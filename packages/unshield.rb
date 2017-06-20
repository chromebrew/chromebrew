require 'package'

class Unshield < Package
  description 'Tool and library to extract CAB files from InstallShield installers.'
  homepage 'https://github.com/twogood/unshield'
  version '1.4.2'
  source_url 'https://github.com/twogood/unshield/archive/1.4.2.tar.gz'
  source_sha1 '02935c888b04507f0a14036773539a4f8c20a152'

  depends_on 'cmake'

  def self.build
    system 'cmake .'
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp man/* #{CREW_DEST_DIR}/usr/local/man/man1"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Unshield < Package
  description 'Tool and library to extract CAB files from InstallShield installers.'
  homepage 'https://github.com/twogood/unshield'
  version '1.4.2'
  source_url 'https://github.com/twogood/unshield/archive/1.4.2.tar.gz'
  source_sha256 '5dd4ea0c7e97ad8e3677ff3a254b116df08a5d041c2df8859aad5c4f88d1f774'

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

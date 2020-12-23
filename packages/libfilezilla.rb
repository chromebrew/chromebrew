require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.26'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.26.0.tar.bz2'
  source_sha256 '17ed226593e8e466ce3c3f8ce583b36c79f163189ead54d631613cc3da5c80bd'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

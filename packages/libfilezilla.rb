require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.15.1'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.15.1.tar.bz2'
  source_sha256 '2048c4128f3bf37a2a4ece17c8bea5455f3d7414fe2e060afcf2a8b00a87f49f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.15.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.15.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.15.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.15.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9f0c812627b00d80513fd6efa9f26151f7fd91be28277f387fe8f950fe59d7ac',
     armv7l: '9f0c812627b00d80513fd6efa9f26151f7fd91be28277f387fe8f950fe59d7ac',
       i686: '85e40754a5dcb32e2f77b2bd95e0e25d1a8319e9a8bb09688596b44c279ba715',
     x86_64: '607e93feabe4f830aa05379bd1a1b9930f6253ba9ab3bede5ee56f60ac542de5',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

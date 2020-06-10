require 'package'

class Fakeroot_ng < Package
  description 'Fakeroot-ng is a clean re-implementation of fakeroot.'
  homepage 'https://fakeroot-ng.lingnu.com/index.php/Home_Page'
  version '0.18'
  compatibility 'x86_64'
  case ARCH
  when 'x86_64'
    source_url 'https://sourceforge.net/projects/fakerootng/files/fakeroot-ng/fakeroot-ng-0.18.tar.gz'
    source_sha256 '189eacda630752980d40e34b2c01ce23d839daab3d691a4706bb9eac79f7e144'
  end

  binary_url ({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fakeroot_ng-0.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    x86_64: '68ade929172b332a688333874644ce80d3af25f9604c9cc68103975c667f4fee',
  })

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-memdir=#{CREW_PREFIX}/tmp"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system 'make', 'check'
  end
end

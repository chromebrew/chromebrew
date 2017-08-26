require 'package'

class Make < Package
  description 'GNU Make is a tool which controls the generation of executables and other non-source files of a program from the program\'s source files.'
  homepage 'https://www.gnu.org/software/make/'
  version '4.2.1'
  source_url 'https://ftp.gnu.org/gnu/make/make-4.2.1.tar.bz2'
  source_sha256 'd6e262bf3601b42d2b1e4ef8310029e1dcf20083c5446b4b7aa67081fdffc589'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/make-4.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/make-4.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/make-4.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/make-4.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bbfd8a8ab6ab5caae56b259ebede8ebf269efbb76999eab8809aa86256b3403e',
     armv7l: 'bbfd8a8ab6ab5caae56b259ebede8ebf269efbb76999eab8809aa86256b3403e',
       i686: '979bc4e45fb8367c68cdccfa13b2d5f920fd7543c287963cc072fd1bc0682163',
     x86_64: 'ebab3261fbd37c88586894e3f79c1eedfbc3d24d999996bc5abb974a8a07980a',
  })

  depends_on 'gcc' => :build
  depends_on 'linuxheaders' => :build

  def self.build
    system "./configure"
    system "./build.sh"
  end

  def self.install
    system "./make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # Give it several tries since output-sync fails rarely
    system "./make check || ./make check || ./make check"
  end
end

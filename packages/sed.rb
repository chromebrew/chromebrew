require 'package'

class Sed < Package
  description 'sed (stream editor) is a non-interactive command-line text editor.'
  homepage 'https://www.gnu.org/software/sed/'
  version '4.7'
  source_url 'https://ftpmirror.gnu.org/sed/sed-4.7.tar.xz'
  source_sha256 '2885768cd0a29ff8d58a6280a270ff161f6a3deb5690b2be6c49f46d4c67bd6a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sed-4.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5d00ca35b334ed7bc07e7e123418384941ed6a694f4246584c9c921775d61eae',
     armv7l: '5d00ca35b334ed7bc07e7e123418384941ed6a694f4246584c9c921775d61eae',
       i686: 'c5c0b651dd7226dbd1ac4e6cf734c825e2ba92ec2efeddfac66bd160304438cf',
     x86_64: '201529831d7b7d138bf29c6779b1377f2d1cddbf98b4f157c320fec078a11af5',
  })

  depends_on 'acl'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--without-selinux'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # Remove selinux tests since we're building without it.
    system "sed -i 's,testsuite/inplace-selinux.sh ,,' Makefile"
    system "make", "check"
  end
end

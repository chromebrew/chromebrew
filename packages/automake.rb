require 'package'

class Automake < Package
  description 'Automake is a tool for automatically generating Makefile.in files compliant with the GNU Coding Standards.'
  homepage 'http://www.gnu.org/software/automake/'
  version '1.15.1'
  source_url 'https://ftp.gnu.org/gnu/automake/automake-1.15.1.tar.xz'
  source_sha256 'af6ba39142220687c500f79b4aa2f181d9b24e4f8d8ec497cea4ba26c64bedaf'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/automake-1.15.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/automake-1.15.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/automake-1.15.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/automake-1.15.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6b24c2151919dec05fe5db181594b8a0c9064de3b2c84ed297a6a206428863b5',
     armv7l: '6b24c2151919dec05fe5db181594b8a0c9064de3b2c84ed297a6a206428863b5',
       i686: '0a65312bf54e75983674a7933a01e073f625f073ba25fcb071185b2722797dc6',
     x86_64: '9a354fc263d5e4118ae563f82f78a56df4d928271969a1b2bcba915f4ae85cac',
  })

  depends_on 'autoconf'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

require 'package'

class Ctags < Package
  description 'Exuberant Ctags is a multilanguage reimplementation of the Unix ctags utility.'
  homepage 'https://sourceforge.net/projects/ctags/'
  version '5.8-0'
  compatibility 'all'
  source_url 'http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz'
  source_sha256 '0e44b45dcabe969e0bbbb11e30c246f81abe5d32012db37395eb57d66e9e99c7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ctags-5.8-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd9eb4193eca3a4c7939d8e9e35ba63cbf8be084982f98c6ba0d9c4d12f3ca762',
     armv7l: 'd9eb4193eca3a4c7939d8e9e35ba63cbf8be084982f98c6ba0d9c4d12f3ca762',
       i686: '5afeda5261207a409a7569ec903df5c47845f237dedc9e78bd0a85bed4b780cc',
     x86_64: 'ab996808d0c2c63d729e036cd12d5a38829dfb4bf9c5ee240db1f7201a55c723',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    #system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"  # it does not work here
    system "install -Dm755 ctags #{CREW_DEST_PREFIX}/bin/ctags"
    system "gzip -9 ctags.1"
    system "install -Dm644 ctags.1.gz #{CREW_DEST_PREFIX}/share/man/man1/ctags.1.gz"
  end
end

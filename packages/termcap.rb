require 'package'

class Termcap < Package
  description 'A library for sending terminal control codes.'
  homepage 'https://www.gnu.org/software/termutils/'
  version '1.3.1'
  source_url 'https://ftp.gnu.org/gnu/termcap/termcap-1.3.1.tar.gz'
  source_sha256 '91a0e22e5387ca4467b5bcb18edf1c51b930262fd466d5fda396dd9d26719100'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/termcap-1.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/termcap-1.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/termcap-1.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/termcap-1.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e2f4e67a5938e52e12efc5aae5c4c38a3f24edb1b370c9b53707c90435ce4c73',
     armv7l: 'e2f4e67a5938e52e12efc5aae5c4c38a3f24edb1b370c9b53707c90435ce4c73',
       i686: '8cd4486501e26bd19b39357e40f3af5c544521325bd4e12d7f26b3284791bae9',
     x86_64: 'ffd35484d885a8b7d01de955dff53c94a448823d9b998b08d6ec73a9d9f5af38',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

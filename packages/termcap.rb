require 'package'

class Termcap < Package
  description 'A library for sending terminal control codes.'
  homepage 'https://www.gnu.org/software/termutils/'
  version '1.3.1'
  source_url 'https://ftp.gnu.org/gnu/termcap/termcap-1.3.1.tar.gz'
  source_sha256 '91a0e22e5387ca4467b5bcb18edf1c51b930262fd466d5fda396dd9d26719100'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

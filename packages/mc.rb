require 'package'

class Mc < Package
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.25'
  compatibility 'all'
  source_url 'https://github.com/MidnightCommander/mc/archive/4.8.25.tar.gz'
  source_sha256 '8a4aa1556a528fbe9140c47aa3d0665155187468a17c3b80a824de5fcbbebae1'

  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'glib' => :build
  depends_on 'libssh2'
  depends_on 'aspell'
  depends_on 'slang'
    
ENV['LIBS'] = "-ldl -lssl -lcrypto"

  def self.build
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
require 'package'

class Mc < Package
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.20'
  source_url 'https://github.com/MidnightCommander/mc/archive/4.8.20.tar.gz'
  source_sha256 'f6d6aebc5ab835f0593b9c30debb39bec05c8073a486aed661e09da3ebe488f9'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'glib' => :build
  depends_on 'aspell'
  depends_on 'slang'

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

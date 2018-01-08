require 'package'

class Whiptail < Package
  description 'displays dialog boxes from shell scripts.'
  homepage 'http://www.linuxfromscratch.org/blfs/view/cvs/general/newt.html'
  version '0.52.20'
  source_url 'https://releases.pagure.org/newt/newt-0.52.20.tar.gz'
  source_sha256 '8d66ba6beffc3f786d4ccfee9d2b43d93484680ef8db9397a4fb70b5adbb6dbc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'popt'
  depends_on 'slang'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

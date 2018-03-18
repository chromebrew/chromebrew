require 'package'

class Mate_desktop < Package
  description 'Libraries for the MATE desktop that are not part of the UI.'
  homepage 'https://mate-desktop.org'
  version '1.20'
  source_url 'https://pub.mate-desktop.org/releases/1.20/mate-desktop-1.20.0.tar.xz'
  source_sha256 '36d0722750ce30ba8d4b8b735bef6ad1b1b4c8f9f51257e36ec419b9b438a178'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
    system "pip uninstall --yes six"
  end
  
end

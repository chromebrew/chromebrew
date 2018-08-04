require 'package'

class Atkmm < Package
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.27.1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/atkmm/2.27/atkmm-2.27.1.tar.xz'
  source_sha256 'cf40bca4ae917bdc2a335cd8c9a9ad84859d8cfb4f8e3dd7741676948e28338c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'atk'
  depends_on 'glibmm'

  def self.build
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/atkmm-2.24.2/' \
    -i doc/Makefile.in"
    ENV["PKG_CONFIG_PATH"] = "#{CREW_LIB_PREFIX}/pkgconfig"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
 end

end

require 'package'

class Libxpm < Package
  description 'X.org X Pixmap Library'
  homepage 'http://www.x.org'
  version '3.5.12'
  source_url 'https://www.x.org/archive//individual/lib/libXpm-3.5.12.tar.gz'
  source_sha256 '2523acc780eac01db5163267b36f5b94374bfb0de26fc0b5a7bee76649fd8501'

  depends_on 'libx11'
  depends_on 'util_macros'
  depends_on 'gettext'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
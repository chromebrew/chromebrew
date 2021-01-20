require 'package'

class Nitrogen < Package
  description 'Background browser and setter for X windows.'
  homepage 'https://github.com/l3ib/nitrogen'
  version '1.6.1'
  compatibility 'all'
  source_url 'https://github.com/l3ib/nitrogen/archive/1.6.1.tar.gz'
  source_sha256 '12ad31c1e2c44f486b5ca7f7d48bc5b07fb92bf15977e1793624e9e64c38b9a7'

  depends_on 'gtkmm2'
  depends_on 'gtkmm3'
  depends_on 'gtk2'
  depends_on 'gtk3'

  ENV['CFLAGS'] = "-lX11 -lXau"


  def self.build
    system "autoreconf -fi"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

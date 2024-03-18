require 'buildsystems/autotools'

class Gtkmm2 < Autotools
  description 'The Gtkmm2 package provides a C++ interface to GTK+ 2.'
  homepage 'https://www.gtkmm.org/'
  version '2.24.5'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtkmm/2.24/gtkmm-2.24.5.tar.xz'
  source_sha256 '0680a53b7bf90b4e4bf444d1d89e6df41c777e0bacc96e9c09fc4dd2f5fe6b72'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'dac13fa160bade1d77733cc368cc55a901285d2901bc5a0e58e667cc9e5158d1',
     armv7l: 'dac13fa160bade1d77733cc368cc55a901285d2901bc5a0e58e667cc9e5158d1',
     x86_64: 'ee4cb765b361813661d8be16a85f74ff60d5426cd34ac11eeecd2c4dadce3599'
  })

  depends_on 'atkmm'
  depends_on 'gtk2'
  depends_on 'pangomm'

  gnome
  no_upstream_update

  def self.patch
    # fix the documents directory name
    system "sed -e '/^libdocdir =/ s/$(book_name)/gtkmm-2.24.5/' \
    -i docs/Makefile.in"
  end
end

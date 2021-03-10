require 'package'

class Libgsf < Package
  description 'The G Structured File Library'
  homepage 'https://gitlab.gnome.org/GNOME/libgsf'
  @_ver = '1.14.47'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/libgsf/#{@_ver_prelastdot}/libgsf-#{@_ver}.tar.xz"
  source_sha256 'd188ebd3787b5375a8fd38ee6f761a2007de5e98fa0cf5623f271daa67ba774d'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgsf-1.14.47-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgsf-1.14.47-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgsf-1.14.47-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgsf-1.14.47-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fdb327f0c46a75e3cd5c5e4bc7e2701fe5b622881837894f9b2314bcc4b29501',
     armv7l: 'fdb327f0c46a75e3cd5c5e4bc7e2701fe5b622881837894f9b2314bcc4b29501',
       i686: '200b8890ef591be47d6554bb280d4a60fcf2798bf2f970910207e3471c733842',
     x86_64: '8d8c0cf26f3bad537ddc82020078ebb52062f83c7a33709f1b2c4cac0abc33c6'
  })

  depends_on 'gdk_pixbuf'
  depends_on 'gtk_doc'

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-shared=yes \
      --disable-maintainer-mode \
      --enable-introspection"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

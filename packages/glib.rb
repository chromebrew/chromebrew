require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.54.3'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.54/glib-2.54.3.tar.xz'
  source_sha256 '963fdc6685dc3da8e5381dfb9f15ca4b5709b28be84d9d05a9bb8e446abac0a8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.54.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.54.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.54.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.54.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '533eee98c648b7af3086b3b5bd3afc59c97f937f82e49fe0fbbba682401f4ca3',
     armv7l: '533eee98c648b7af3086b3b5bd3afc59c97f937f82e49fe0fbbba682401f4ca3',
       i686: 'd016992203d3c04ed4330a2bdbbb740d5fb6a2bd1d79a18d7fd4bcd351fd518d',
     x86_64: 'e187d92566f91d8cf52a4896a6f21b1c612c1e2c84d77d33837b80e64e5ffba3',
  })


  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'util_linux'
  depends_on 'zlibpkg'
  depends_on 'python27'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-pcre"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

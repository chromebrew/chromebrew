require 'package'

class Gobject_introspection < Package
  description 'GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.'
  homepage 'https://wiki.gnome.org/action/show/Projects/GObjectIntrospection'
  version '1.52.1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.52/gobject-introspection-1.52.1.tar.xz'
  source_sha256 '2ed0c38d52fe1aa6fc4def0c868fe481cb87b532fc694756b26d6cfab29faff4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.52.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.52.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.52.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gobject_introspection-1.52.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cef6d20359ec63d73eb2f4f9446f4a2d9d10ddce89a3101bb2689dca59f1c3ec',
     armv7l: 'cef6d20359ec63d73eb2f4f9446f4a2d9d10ddce89a3101bb2689dca59f1c3ec',
       i686: 'a01838c57af9d90964c2cf4c9efa13f21cf639cae38e7fe0c34f2bc59797c3d6',
     x86_64: '1579109ca32ff57a7b8dd4aeac198d09f4131998bf9127e992fb4df81f4967eb',
  })

  depends_on 'glib'
  depends_on 'cairo'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

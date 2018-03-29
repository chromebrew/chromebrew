require 'package'

class Libsoup < Package
  description 'An HTTP library implementation in C.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.54.1'
  source_url 'https://download.gnome.org/sources/libsoup/2.54/libsoup-2.54.1.tar.xz'
  source_sha256 '47b42c232034734d66e5f093025843a5d8cc4b2357c011085a2fd04ef02dd633'

  depends_on 'libxml2'
  depends_on 'sqlite'
  depends_on 'glib_networking'
  depends_on 'krb5'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'gtk_doc'
  depends_on 'vala'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
    system "pip uninstall --yes six"
  end
  
end

require 'package'

class Dbus_glib < Package
  description 'D-Bus bindings for glib.'
  homepage 'https://dbus.freedesktop.org'
  version '1.13.2'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.13.2.tar.gz'
  source_sha256 '945deb349a7e2999184827c17351c1bf93c6395b9c3ade0c91cad42cb93435b1'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end

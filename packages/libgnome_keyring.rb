require 'package'

class Libgnome_keyring < Package
  description 'GNOME keyring client library'
  homepage 'https://www.gnome.org'
  version '3.12.0'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libgnome-keyring/3.12/libgnome-keyring-3.12.0.tar.xz'
  source_sha256 'c4c178fbb05f72acc484d22ddb0568f7532c409b0a13e06513ff54b91e947783'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgnome_keyring-3.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgnome_keyring-3.12.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgnome_keyring-3.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'db8b7355277ec22342f1cebe983de9a70dc0638c0fe5f42e7c4ef24ea6b42c81',
     armv7l: 'db8b7355277ec22342f1cebe983de9a70dc0638c0fe5f42e7c4ef24ea6b42c81',
     x86_64: '7cd854b285d63aab304bd06aa13f63e4264e3643a7a3917fdc3e944445986f5a',
  })

  depends_on 'dbus'
  depends_on 'libgcrypt'
  depends_on 'llvm' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-introspection=no --enable-vala=no"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end

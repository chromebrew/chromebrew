require 'buildsystems/autotools'

class Libgnome_keyring < Autotools
  description 'GNOME keyring client library'
  homepage 'https://www.gnome.org'
  version '3.12.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libgnome-keyring/3.12/libgnome-keyring-3.12.0.tar.xz'
  source_sha256 'c4c178fbb05f72acc484d22ddb0568f7532c409b0a13e06513ff54b91e947783'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'db8b7355277ec22342f1cebe983de9a70dc0638c0fe5f42e7c4ef24ea6b42c81',
     armv7l: 'db8b7355277ec22342f1cebe983de9a70dc0638c0fe5f42e7c4ef24ea6b42c81',
     x86_64: '7cd854b285d63aab304bd06aa13f63e4264e3643a7a3917fdc3e944445986f5a'
  })

  depends_on 'dbus'
  depends_on 'libgcrypt'
  depends_on 'llvm18_lib' => :build

  gnome

  configure_options '--enable-introspection=no --enable-vala=no'
end

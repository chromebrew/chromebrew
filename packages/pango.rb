require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.41-1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/pango/1.41/pango-1.41.0.tar.xz'
  source_sha256 '1f76ef95953dc58ee5d6a53e5f1cb6db913f3e0eb489713ee9266695cae580ba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.41-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.41-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.41-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pango-1.41-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f65adb402f6e56091ef82e5ea294fe90be01150a6f711f93d37f26294f50e3db',
     armv7l: 'f65adb402f6e56091ef82e5ea294fe90be01150a6f711f93d37f26294f50e3db',
       i686: 'dff892010b000889b24a6cc550884b8eb5737031ccbe1bbce8b4741044b9d472',
     x86_64: '74886d31f0f888d8e7a3fe850342534b2e31bf2dcbc253cf1a170640c45ea0ea',
  })

  depends_on 'diffutils' => :build
  depends_on 'harfbuzz'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'perl'
  depends_on 'gobject_introspection'   # add this package to build gtk+, avoid compilation error
  depends_on 'python27'                # need six package from python to install Pango


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"   # fix installation error,  "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} six" does not work
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
end

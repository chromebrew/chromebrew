require 'package'

class Wxwidgets < Package
  description 'wxWidgets is a C++ library that lets developers create applications for Windows, macOS, Linux and other platforms with a single code base.'
  homepage 'https://www.wxwidgets.org/'
  version '3.0.5.1'
  source_url 'https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.5.1/wxWidgets-3.0.5.1.tar.bz2'
  source_sha256 '440f6e73cf5afb2cbf9af10cec8da6cdd3d3998d527598a53db87099524ac807'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gst_plugins_base'
  depends_on 'libnotify'
  depends_on 'libsdl'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'mesa'
  depends_on 'gtk3'

  def self.build
    system "./configure #{CREW_OPTIONS} --with-gtk"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end

require 'package'

class Libwmf < Package
  description 'libwmf is a library for reading vector images in Microsoft\'s native Windows Metafile Format (WMF)'
  homepage 'https://github.com/caolanm/libwmf'
  version '0.2.12-483e'
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://github.com/caolanm/libwmf/archive/483ee1e8d4ee11690f3459d4b4d527f69af7b9c9.zip'
  source_sha256 'ec31cc81ee41ab28acef686b875b7692f6a5286710d6fd58429d914f78c73847'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.12-483e-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.12-483e-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.12-483e-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.12-483e-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6313c27b04e538ce75b749049658d7ad0f85df880a24f49f232e1846a32535b2',
     armv7l: '6313c27b04e538ce75b749049658d7ad0f85df880a24f49f232e1846a32535b2',
       i686: 'dffff92d3d43cd2925d2cb7bef79cdf8454d00b5a381521d7cab12a75b3f827e',
     x86_64: 'a870df8f42498dc2a8a07c359ff453add7623bf6dd49633ba69f12e9fe8bd5d4'
  })

  depends_on 'gtk2'
  depends_on 'libgd'
  depends_on 'libjpeg'
  depends_on 'xorg_server'
  depends_on 'gdk_pixbuf'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'gdk-pixbuf-query-loaders --update-cache'
  end
end

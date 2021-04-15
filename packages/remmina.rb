require 'package'

class Remmina < Package
  description 'The GTK Remmina Remote Desktop Client'
  homepage 'https://remmina.org/'
  version '1.4.13'
  license 'GPL-2+-with-openssl-exception'
  compatibility 'all'
  source_url "https://gitlab.com/Remmina/Remmina/-/archive/v#{version}/Remmina-v#{version}.tar.bz2"
  source_sha256 '24531287b85b2500b172cbe125f829c0dcf008c887ffa5e1b19a29c23d902885'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/remmina-1.4.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/remmina-1.4.13-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/remmina-1.4.13-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/remmina-1.4.13-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e42b0d7595f28712a818d3570274dd3070063c37ec6850da22d8e976a7a77f5d',
     armv7l: 'e42b0d7595f28712a818d3570274dd3070063c37ec6850da22d8e976a7a77f5d',
       i686: '31f3bcec48acb1d5acff7ca15a24b8b933f05d176ab8066794b1ceb9c8409f24',
     x86_64: '6028f81de9c1fb93ed41726884305fa31d706a5cc66f1df7cfdf45ed533b176b'
  })

  depends_on 'avahi'
  depends_on 'freerdp'
  depends_on 'libsecret'
  depends_on 'libsodium'
  depends_on 'libsoup'
  depends_on 'libvncserver'
  depends_on 'spice_gtk'
  depends_on 'vte'
  depends_on 'webkit2gtk_4'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DWITH_APPINDICATOR=OFF \
        -DWITH_TELEPATHY=OFF \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

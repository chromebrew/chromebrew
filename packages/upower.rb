require 'package'

class Upower < Package
  description 'Abstraction for enumerating power devices, listening to device events and querying history and statistics'
  homepage 'https://upower.freedesktop.org'
  @_ver = '0.99.11'
  @_ver_ = @_ver.gsub(/[.]/, '_')
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/upower/upower/-/archive/UPOWER_#{@_ver_}/upower-UPOWER_#{@_ver_}.tar.bz2"
  source_sha256 'd50961ff6d2c5bc5e9b8ef6611a12dc8933f722ebf7de245b97fbe72999ebd9b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/upower-0.99.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/upower-0.99.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/upower-0.99.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/upower-0.99.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f424ee9ea8fa6d96c9765983fb3ba67564ac7ce4531ba3302b28a7dc2c54c9f5',
     armv7l: 'f424ee9ea8fa6d96c9765983fb3ba67564ac7ce4531ba3302b28a7dc2c54c9f5',
       i686: 'ce0952caa0be85214e627dbc1f910d5aba538b1e53e0ae459a329b85ed962ae9',
     x86_64: '1a6543c4260568e9224dc1497cca57d99c0a1f0bd54ddd95267ea28b420fad1c'
  })

  depends_on 'libusb'
  depends_on 'libgudev'
  depends_on 'docbook_xsl' => ':build'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk_doc' => ':build'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --localstatedir=#{CREW_PREFIX}/var \
      --libexecdir=#{CREW_PREFIX}/libexec \
      --enable-gtk-doc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end

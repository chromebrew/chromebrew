require 'package'

class Libwacom < Package
  description 'libwacom is a wrapper library for evdev devices.'
  homepage 'https://github.com/linuxwacom/libwacom'
  version '1.12'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/linuxwacom/libwacom.git'
  git_hashtag "libwacom-#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'f7c3aa3b6f959b942e83ac4906ec57e70d1af52db9d9896684a3be2451353f65',
     armv7l: 'f7c3aa3b6f959b942e83ac4906ec57e70d1af52db9d9896684a3be2451353f65',
     x86_64: '4ea8c93a5be266921a869d1aa39600bf19aec35a2481ed71415ee2c74ba8840a'
  })

  depends_on 'libgudev'
  depends_on 'eudev'
  depends_on 'libevdev'
  depends_on 'py3_libevdev' => :build
  depends_on 'py3_pyudev' => :build
  depends_on 'py3_pytest' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dtests=disabled \
      builddir"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end

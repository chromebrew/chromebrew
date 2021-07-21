require 'package'

class Libwacom < Package
  description 'libwacom is a wrapper library for evdev devices.'
  homepage 'https://github.com/linuxwacom/libwacom'
  @_ver = '1.11'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/linuxwacom/libwacom.git"
  git_hashtag 'libwacom-' + @_ver

  depends_on 'libgudev'
  depends_on 'eudev'
  depends_on 'libevdev'
  depends_on 'py3_libevdev' => :build
  depends_on 'py3_pyudev' => :build
  depends_on 'py3_pytest' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dtests=disabled \
      builddir"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end

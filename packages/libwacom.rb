require 'package'

class Libwacom < Package
  description 'libwacom is a wrapper library for evdev devices.'
  homepage 'https://github.com/linuxwacom/libwacom'
  @_ver = '1.11'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/linuxwacom/libwacom.git'
  git_hashtag "libwacom-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwacom/1.11_armv7l/libwacom-1.11-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwacom/1.11_armv7l/libwacom-1.11-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwacom/1.11_i686/libwacom-1.11-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwacom/1.11_x86_64/libwacom-1.11-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3f82ff53c82a48d4fc98b628f4d8be620872f4751e199779b861ee3045c7350e',
     armv7l: '3f82ff53c82a48d4fc98b628f4d8be620872f4751e199779b861ee3045c7350e',
       i686: '52e75577ecd3ded6104aa7286cf6e4b8d24e7199fa9236e0f79a1a2cd98bfe61',
     x86_64: '479764662e888c2c014b0a4f95a359adf8f892d7f08283b5e7fc3d16798d85ca'
  })

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

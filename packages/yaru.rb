require 'package'

class Yaru < Package
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '21.04.1'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'all'
  source_url "https://github.com/ubuntu/yaru/archive/refs/tags/#{version}.tar.gz"
  source_sha256 '8cbbb1fcc7fa1e46e48d870cc1f941069e8213ac53200001aa9548ad79086836'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yaru/21.04.1_armv7l/yaru-21.04.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yaru/21.04.1_armv7l/yaru-21.04.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yaru/21.04.1_i686/yaru-21.04.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/yaru/21.04.1_x86_64/yaru-21.04.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b13e932b15e3867f2243d230cc6cdb36c475227a7167e298634cb72a48e37d0c',
     armv7l: 'b13e932b15e3867f2243d230cc6cdb36c475227a7167e298634cb72a48e37d0c',
       i686: 'e80256dad9b7a6cb34c3316a8138a038f7cfd8ff31ab0f5d062a11d553aebc61',
     x86_64: '8642491d0f1fc9a77047bc7ff348b8f8af381255e1b40dfb1226f0855c40176c'
  })

  depends_on 'sassc'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dubuntu-unity=true \
      build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end

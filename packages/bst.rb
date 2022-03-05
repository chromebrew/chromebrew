require 'package'

class Bst < Package
  description 'bst (pronounced "bestie") is a one-stop shop for running programs in isolated Linux environments.'
  homepage 'https://github.com/aristanetworks/bst'
  version '1.0.0-rc1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/aristanetworks/bst.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bst/1.0.0-rc1_armv7l/bst-1.0.0-rc1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bst/1.0.0-rc1_armv7l/bst-1.0.0-rc1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bst/1.0.0-rc1_x86_64/bst-1.0.0-rc1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '867f159bc4b7a6951bbc2cac8358bf313a4cccd0f62c7f56cbf2f96b69764964',
     armv7l: '867f159bc4b7a6951bbc2cac8358bf313a4cccd0f62c7f56cbf2f96b69764964',
     x86_64: 'df1255b0bc150e8a323396cdba09acfb16137495b2d1aa07860577ae2c7df842'
  })

  depends_on 'scdoc' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dno-setcap-or-suid=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end

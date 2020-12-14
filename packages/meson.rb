require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.56.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson/archive/0.56.0.tar.gz'
  source_sha256 'a9ca7adf66dc69fbb7e583f7c7aef16b9fe56ec2874a3d58747e69a3affdf300'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6908c0f971832f710fd6f03711ff1c593198bca01fc6c195aa8e596e03bc3c03',
     armv7l: '6908c0f971832f710fd6f03711ff1c593198bca01fc6c195aa8e596e03bc3c03',
       i686: 'b63ee258889c30587a784dcfd934edf6306215b57bcfd13cd0bc00c8866de34f',
     x86_64: '0141299bd8810a52b23f5985cd4d4682b6b4207ecfebac86d4c58248acfb14ab',
  })

  depends_on 'ninja'
  depends_on 'setuptools'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

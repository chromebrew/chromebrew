require 'package'

class Kbfsfuse < Package
  description 'Keybase fuse filesystem.'
  homepage 'https://keybase.io/docs/kbfs'
  version '1.0.40'
  compatibility 'all'
  source_url 'https://github.com/keybase/kbfs/archive/v1.0.40.tar.gz'
  source_sha256 '2bbbfd2eb7ed12295375a182656af6dcc509827f7ed83c2b1dd0f72f56853fa5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/kbfsfuse-1.0.40-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/kbfsfuse-1.0.40-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/kbfsfuse-1.0.40-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/kbfsfuse-1.0.40-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fdf320e2c52383d11ecfc3c1ab355e2950d1acc6b23583b9751b7c296948dc2e',
     armv7l: 'fdf320e2c52383d11ecfc3c1ab355e2950d1acc6b23583b9751b7c296948dc2e',
       i686: '1b17dfe14583bdd5a8eec019efd242563132ce7e513b50a411cb58db7d9907ea',
     x86_64: 'e225df2cae3b2dadc90adc1983f6adcdaa41e1846df2936d0e8a1a2a42811a96',
  })

  depends_on 'keybase'

  def self.install
    system "go get github.com/keybase/kbfs/kbfsfuse"
    system "go build -o #{CREW_DEST_PREFIX}/bin/kbfsfuse -tags production github.com/keybase/kbfs/kbfsfuse"
  end
end

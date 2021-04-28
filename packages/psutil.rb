require 'package'

class Psutil < Package
  description 'psutil (process and system utilities) is a cross-platform library for retrieving information on running processes and system utilization in Python.'
  homepage 'https://github.com/giampaolo/psutil'
  version '5.8.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/giampaolo/psutil/archive/refs/tags/release-5.8.0.tar.gz'
  source_sha256 'c015248da36109ffaa15f46fce8c0003f678cfaa408090f466c80318885e7abf'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/psutil/5.8.0_armv7l/psutil-5.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/psutil/5.8.0_armv7l/psutil-5.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/psutil/5.8.0_i686/psutil-5.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/psutil/5.8.0_x86_64/psutil-5.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '35a8643fdc7141f35a0a91d217a5dedf377bb79790c18dc02f089362dfc8e104',
     armv7l: '35a8643fdc7141f35a0a91d217a5dedf377bb79790c18dc02f089362dfc8e104',
       i686: 'e38537dffaf71ca7e8d9a83c83c63cf4ccbf7929c24d163b7b43dff7e0235450',
     x86_64: '8d99419f62b714a7bc241305db99d5f337b86ba78f0da5be2805bc3a90c90b5d',
  })

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I psutil==#{version} --no-warn-script-location"
  end
end

require 'package'

class Lxml < Package
  description 'Library for processing XML and HTML in the Python language.'
  homepage 'https://lxml.de/'
  version '4.6.1'
  license 'BSD, ElementTree, GPL-2 and PSF-2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lxml/4.6.1_armv7l/lxml-4.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lxml/4.6.1_armv7l/lxml-4.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lxml/4.6.1_i686/lxml-4.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lxml/4.6.1_x86_64/lxml-4.6.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c9b3bfe7891b89b124260f2fd7ac276060649922c9010b4287a13d18deb98c91',
     armv7l: 'c9b3bfe7891b89b124260f2fd7ac276060649922c9010b4287a13d18deb98c91',
       i686: '17ec2f74f7bb91b6cb81d8a58f62328e87002ded622ecc7d2d5216c9fc35139f',
     x86_64: '1951efc4cf2ad7b13fc33f5a8f89e49e5b52e117ca980819ed6ba0c58bbb16d6'
  })

  def self.install
    system 'pip3 uninstall -y lxml'
    system "pip3 install --upgrade --no-warn-script-location lxml --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

require 'package'

class Lxml < Package
  description 'Library for processing XML and HTML in the Python language.'
  homepage 'https://lxml.de/'
  version '4.6.1'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lxml-4.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lxml-4.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lxml-4.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lxml-4.6.1-chromeos-x86_64.tar.xz'
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

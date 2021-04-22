require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  version '2.23'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/thp/urlwatch/archive/2.23.tar.gz'
  source_sha256 'b61997ec6229b2cb22b7121d0b666da91e524e212d126f55cd939d230daa5887'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/urlwatch-2.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/urlwatch-2.23-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/urlwatch-2.23-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/urlwatch-2.23-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1f17b72ee478889438aa358a966b649523793f1c5c97fd19b4eaddaa5f75f7ed',
     armv7l: '1f17b72ee478889438aa358a966b649523793f1c5c97fd19b4eaddaa5f75f7ed',
       i686: '66a0c448752ed7a144e6e73967fb600d5f2784aab59b49279650a156d4cb8b92',
     x86_64: '9d2629ab5d1172e48eb97bd074c5156a6fafe75d1f11a698a85a6cc84a87934c'
  })

  def self.install
    system "CRYPTOGRAPHY_DONT_BUILD_RUST=1 pip3 install \
           --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -r requirements.txt"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

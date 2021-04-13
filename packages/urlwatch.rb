require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  version '2.7-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/thp/urlwatch/archive/2.7.tar.gz'
  source_sha256 '0a7b46d161501463dda99a1d82daf00237e2627616beaa6ccbf04d6c70c68ded'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/urlwatch-2.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/urlwatch-2.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/urlwatch-2.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/urlwatch-2.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'daab4655856fab857ec59c3c946aceaba592a74e2e655473ec5189bf2370326e',
     armv7l: 'daab4655856fab857ec59c3c946aceaba592a74e2e655473ec5189bf2370326e',
       i686: 'a19bcb80f178fffd27170d30ebda7f4b113f59ed4249a1c3ca36100e6a589072',
     x86_64: '7c41c7dddfcc0d6ed8563019c047a1c940fe33b1b920b6071a3be8e432367c53',
  })

  def self.install
    system "python3 -m pip install pyyaml minidb requests keyring appdirs chump pushbullet.py pycodestyle --root #{CREW_DEST_DIR}"
    system "pip3 install urlwatch --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

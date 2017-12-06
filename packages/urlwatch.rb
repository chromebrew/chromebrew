require 'package'

class Urlwatch < Package
  description 'A tool for monitoring webpages for updates'
  homepage 'https://thp.io/2008/urlwatch/'
  version '2.7-1'
  source_url 'https://github.com/thp/urlwatch/archive/2.7.tar.gz'
  source_sha256 '0a7b46d161501463dda99a1d82daf00237e2627616beaa6ccbf04d6c70c68ded'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'
  depends_on 'filecmd'

  def self.install
    system "python3 -m pip install pyyaml minidb requests keyring appdirs chump pushbullet.py pycodestyle --root #{CREW_DEST_DIR}"
    system "pip3 install urlwatch --root #{CREW_DEST_DIR}"
  end
end

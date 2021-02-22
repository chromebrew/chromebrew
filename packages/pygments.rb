require 'package'

class Pygments < Package
  description 'Python Syntax Highlighter'
  homepage 'https://pygments.org/'
  version '2.7.3-2'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pygments-2.7.3-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pygments-2.7.3-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pygments-2.7.3-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pygments-2.7.3-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5fe220b1a04d9e1368120ba326fb238ce5e98bf7267c1dae66ab4df0e2b15ffe',
     armv7l: '5fe220b1a04d9e1368120ba326fb238ce5e98bf7267c1dae66ab4df0e2b15ffe',
       i686: 'e6ea0521588e6a30f27d63b2c04c0046a0938fc0896e42c1521b375fe7742b3b',
     x86_64: '281b79540b3ff6515a41660fde00e5863206e39e612ac9cb61d77bfcc4ad3d5d',
  })

  def self.install
    system "pip3 uninstall -y pygments"
    system "pip3 install --upgrade --no-warn-script-location pygments --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

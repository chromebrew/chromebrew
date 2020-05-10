require 'package'

class Duplicity < Package
  description 'Duplicity backs directories by producing encrypted tar-format volumes and uploading them to a remote or local file server.'
  homepage 'http://duplicity.nongnu.org/'
  version '0.7.15'
  compatibility 'all'
  source_url 'https://code.launchpad.net/duplicity/0.7-series/0.7.15/+download/duplicity-0.7.15.tar.gz'
  source_sha256 '50bf7d14413284ecb036146ab9ba0e271937f2fa7826f8c8300b2965eb450a6c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/duplicity-0.7.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/duplicity-0.7.15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/duplicity-0.7.15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/duplicity-0.7.15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '173e42b07ec4d4646cfbe16c78faabf1f7bce3a6b754350058fa1ebc19d82a0b',
     armv7l: '173e42b07ec4d4646cfbe16c78faabf1f7bce3a6b754350058fa1ebc19d82a0b',
       i686: 'f09130b65c2f29bd44204911efaf1a755bf1be74454f4c62f3e77a808b47b090',
     x86_64: 'e122233caf601a05b85b1816ae690be8c1d6e82a83953351c8ecd0ca6046706e',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'librsync'
  depends_on 'gnupg'
  depends_on 'openssh'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} fasteners"
    system "python setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

require 'package'

class Duplicity < Package
  description 'Duplicity backs directories by producing encrypted tar-format volumes and uploading them to a remote or local file server.'
  homepage 'http://duplicity.nongnu.org/'
  version '0.7.15'
  source_url 'https://code.launchpad.net/duplicity/0.7-series/0.7.15/+download/duplicity-0.7.15.tar.gz'
  source_sha256 '50bf7d14413284ecb036146ab9ba0e271937f2fa7826f8c8300b2965eb450a6c'

  binary_url ({
  })
  binary_sha256 ({
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

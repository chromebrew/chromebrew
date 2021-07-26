require 'package'

class Duplicity < Package
  description 'Duplicity backs directories by producing encrypted tar-format volumes and uploading them to a remote or local file server.'
  homepage 'http://duplicity.nongnu.org/'
  version '0.8.19'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/9f/ae/4eb8869a12a531f453ef1d64a0d53dfa6a674895f6222b347f8c96a7a88b/duplicity-0.8.19.tar.gz'
  source_sha256 'd5dda2918058d0e47bf7a1299cfc9b51cc2f0546920fc3cfcf7ae06fc76d68ba'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duplicity/0.8.19_armv7l/duplicity-0.8.19-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duplicity/0.8.19_armv7l/duplicity-0.8.19-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/duplicity/0.8.19_x86_64/duplicity-0.8.19-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '69cffac0a6b444047e073e8d8aff2dcd0f3e362da626ea0cb2824530963aa684',
     armv7l: '69cffac0a6b444047e073e8d8aff2dcd0f3e362da626ea0cb2824530963aa684',
     x86_64: 'a472aa7109a205f91dd16a4e3604bf73ddd7ef5e257eddfd7c63a39ba18eebbc'
  })

  depends_on 'librsync'
  depends_on 'gnupg'
  depends_on 'openssh'
  depends_on 'py3_future'
  depends_on 'py3_fasteners'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

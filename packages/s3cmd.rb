require 'package'

class S3cmd < Package
  description 'Command line tool for managing Amazon S3 and CloudFront services'
  homepage 'http://s3tools.org/s3cmd'
  @_ver = '2.1.0'
  version @_ver
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/s3tools/s3cmd.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/s3cmd/2.1.0_armv7l/s3cmd-2.1.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/s3cmd/2.1.0_armv7l/s3cmd-2.1.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/s3cmd/2.1.0_i686/s3cmd-2.1.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/s3cmd/2.1.0_x86_64/s3cmd-2.1.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '313e17b05c93f876d865cb8f170f191b6d1815b9d344ba53400fd4aa1e523a19',
     armv7l: '313e17b05c93f876d865cb8f170f191b6d1815b9d344ba53400fd4aa1e523a19',
       i686: '9d422dbd45acf2661b3cb2d93f60fe010442765af4f21ebccbd965c7410d1b2a',
     x86_64: '34aae7b83d4197f25bb727a880d7c1580baa003cb6b62fe2c61202795794ddd9'
  })

  depends_on 'py3_dateutil'
  depends_on 'py3_magic'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

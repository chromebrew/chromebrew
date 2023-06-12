require 'package'

class S3cmd < Package
  description 'Command line tool for managing Amazon S3 and CloudFront services'
  homepage 'http://s3tools.org/s3cmd'
  version '2.2.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/s3tools/s3cmd.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/s3cmd/2.2.0_armv7l/s3cmd-2.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/s3cmd/2.2.0_armv7l/s3cmd-2.2.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/s3cmd/2.2.0_i686/s3cmd-2.2.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/s3cmd/2.2.0_x86_64/s3cmd-2.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a56111bcb0829c95c9230715b44f382bf7cd9d5564962ff2c540a1d15502fa24',
     armv7l: 'a56111bcb0829c95c9230715b44f382bf7cd9d5564962ff2c540a1d15502fa24',
       i686: '7b90d554c117d56f7262f979a9f6eed631870aa37cf93c015aacef0657c2ab10',
     x86_64: '55338685fc6229831a5960e6739244c9d4d23160abe8a3be0d7489a937a2a571'
  })

  depends_on 'py3_dateutil'
  depends_on 'py3_magic'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

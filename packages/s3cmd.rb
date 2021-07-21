require 'package'

class S3cmd < Package
  description 'Command line tool for managing Amazon S3 and CloudFront services'
  homepage 'http://s3tools.org/s3cmd'
  @_ver = '2.1.0'
  version @_ver
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/s3tools/s3cmd.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_dateutil'
  depends_on 'py3_magic'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

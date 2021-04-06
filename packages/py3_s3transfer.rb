require 'package'

class Py3_s3transfer < Package
  description 'S3transfer is an Amazon S3 transfer manager'
  homepage 'https://github.com/boto/s3transfer/'
  version '0.3.6'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/boto/s3transfer/archive/0.3.6.tar.gz'
  source_sha256 '7cd8f6439ec3081bb5c25f366d98a7c5e4e9fd65f58e8eb5ca0f6c9684f365d5'

  depends_on 'py3_botocore'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end

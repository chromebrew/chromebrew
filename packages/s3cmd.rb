require 'package'

class S3cmd < Package
  description 's3cmd is a command line tool for managing Amazon S3 and CloudFront services.'
  homepage 'https://s3tools.org/s3cmd/'
  version '2.1.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/s3tools/s3cmd/releases/download/v2.1.0/s3cmd-2.1.0.tar.gz'
  source_sha256 '966b0a494a916fc3b4324de38f089c86c70ee90e8e1cae6d59102103a4c0cc03'

  depends_on 'py3_dateutil'
  depends_on 'py3_magic'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end

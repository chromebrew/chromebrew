require 'package'

class Py3_boto3 < Package
  description 'Boto 3 is the AWS SDK for python.'
  homepage 'https://github.com/boto/boto3/'
  version '0.0.14'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/boto/boto3/archive/0.0.14.tar.gz'
  source_sha256 '41d853467768a88751de680a5d3cb9cc0d6267048b013b33ec2758a477f4c014'

  depends_on 'py3_botocore'
  depends_on 'py3_jmespath'
  depends_on 'py3_s3transfer'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end

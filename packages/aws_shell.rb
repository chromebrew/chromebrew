require 'package'

class Aws_shell < Package
  description 'An integrated shell for working with the AWS CLI.'
  homepage 'https://github.com/awslabs/aws-shell'
  version '0.2.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/awslabs/aws-shell/archive/0.2.2.tar.gz'
  source_sha256 'e8ba32b23c133073bddc3e44a79c7ccba42cb7943757dadfe091ef512818f872'

  depends_on 'awscli'
  depends_on 'py3_boto3'
  depends_on 'py3_configobj'
  depends_on 'py3_prompt_toolkit1'
  depends_on 'py3_pygments'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end

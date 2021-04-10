require 'package'

class Awscli < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.19.45'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/aws/aws-cli/archive/1.19.45.tar.gz'
  source_sha256 '67b2c0066a17a9592767c57e038db93f98d289694c8fc5a27e27b85ffbfa674c'

  depends_on 'py3_botocore'
  depends_on 'py3_colorama'
  depends_on 'py3_docutils'
  depends_on 'py3_pyyaml'
  depends_on 'py3_s3transfer'
  depends_on 'py3_rsa'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    @awsbashrc = <<~AWSBASHRCEOF
      # Amazon Web Services CLI bash completion
      source #{CREW_PREFIX}/bin/aws_bash_completer
    AWSBASHRCEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/aws", @awsbashrc)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/zsh.d"
    @awszshrc = <<~AWSZSHRCEOF
      # Amazon Web Services CLI zsh completion
      source #{CREW_PREFIX}/bin/aws_zsh_completer.sh
    AWSZSHRCEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/zsh.d/aws", @awszshrc)
  end
end

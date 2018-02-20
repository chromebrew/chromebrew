require 'package'

class Aws_shell < Package
  description 'An integrated shell for working with the AWS CLI.'
  homepage 'https://github.com/awslabs/aws-shell'
  version '0.2.0'
  source_url 'https://github.com/awslabs/aws-shell/archive/0.2.0.tar.gz'
  source_sha256 '6d3a333c13c6c4cd3b9f1316a0a0c53ce4807b673dba63882ab2f834c2ffb903'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.install
    system "yes | pip install setuptools"
    system "python setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "pip uninstall setuptools"
  end
end

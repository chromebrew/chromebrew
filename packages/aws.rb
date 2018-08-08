require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.15.71'
  source_url 'https://github.com/aws/aws-cli/archive/1.15.71.tar.gz'
  source_sha256 'b6e60b332853b05b9f3647a7b3b2c575f8e8d389fbce3c1e51201604ff03b6a4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3' unless File.exists? "#{CREW_PREFIX}/bin/python3"

  def self.install
    system "cat requirements-docs.txt >> requirements.txt"
    system "sed -i 's,-e git://github.com/boto/botocore.git@develop#egg=botocore,botocore,g' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/s3transfer.git@develop#egg=s3transfer,s3transfer,g' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/jmespath.git@develop#egg=jmespath,jmespath,g' requirements.txt"
    system "cat requirements.txt"
    system "pip3 install aws -r requirements.txt --upgrade --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "pip2 install aws -r requirements.txt --upgrade --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "pip2 install aws -r requirements26.txt --upgrade --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py build"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python2 setup.py build"
    system "python2 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

require 'package'

class Aws < Package
  description 'The AWS CLI is an open source tool built on top of the AWS SDK for Python (Boto) that provides commands for interacting with AWS services.'
  homepage 'https://aws.amazon.com/documentation/cli/'
  version '1.16.25'
  source_url 'https://github.com/aws/aws-cli/archive/1.16.25.tar.gz'
  source_sha256 '7c785969c320d8f00c5f4b6daee9e7f1377ec0de045ff811a645b709f534fd82'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'

  def self.build
    system "cat requirements-docs.txt >> requirements.txt"
    system "sed -i 's,-e git://github.com/boto/botocore.git@develop#egg=botocore,botocore,g' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/s3transfer.git@develop#egg=s3transfer,s3transfer,g' requirements.txt"
    system "sed -i 's,-e git://github.com/boto/jmespath.git@develop#egg=jmespath,jmespath,g' requirements.txt"
    system "python3 setup.py build"
  end

  def self.install
    system "pip3 install aws -r requirements.txt --upgrade --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

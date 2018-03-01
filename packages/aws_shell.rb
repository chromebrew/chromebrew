require 'package'

class Aws_shell < Package
  description 'An integrated shell for working with the AWS CLI.'
  homepage 'https://github.com/awslabs/aws-shell'
  version '0.2.0'
  source_url 'https://github.com/awslabs/aws-shell/archive/0.2.0.tar.gz'
  source_sha256 '6d3a333c13c6c4cd3b9f1316a0a0c53ce4807b673dba63882ab2f834c2ffb903'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws_shell-0.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws_shell-0.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws_shell-0.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws_shell-0.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a487ad655f5b496a4aa496bfd8fcccddf3f2c484f2d55e9b64070d3e9ea93c3c',
     armv7l: 'a487ad655f5b496a4aa496bfd8fcccddf3f2c484f2d55e9b64070d3e9ea93c3c',
       i686: '89e641e7093bd9fb08ae6886de51ceb6bf8162ea0c61b4e783002a388059b847',
     x86_64: 'c88f2778b54fd031d1f74f4698c8dfc9fbde806c09990beef9335d32d83a1e9d',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.install
    system "yes | pip install setuptools"
    system "python setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "pip uninstall setuptools"
  end
end

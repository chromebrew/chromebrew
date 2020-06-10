require 'package'

class Aws_shell < Package
  description 'An integrated shell for working with the AWS CLI.'
  homepage 'https://github.com/awslabs/aws-shell'
  version '0.2.1'
  compatibility 'all'
  source_url 'https://github.com/awslabs/aws-shell/archive/0.2.1.tar.gz'
  source_sha256 '84262f0ccba6757a318ce415d8a77026b43db958cfac9ef615e75c3515d78f78'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aws_shell-0.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aws_shell-0.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aws_shell-0.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aws_shell-0.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b973100dd69dc756fd4578fd8776670279f8dcbe086e9c3874997aa0f2425bb',
     armv7l: '7b973100dd69dc756fd4578fd8776670279f8dcbe086e9c3874997aa0f2425bb',
       i686: '69f956d76dd2c0acc500f2253310bb719c4b08573f72922d98fd9c0ebf1239e4',
     x86_64: '41ad9b4fbe0104c4e7d48fb7b5c2469f89562f46c1184b985114da37bf0ed479',
  })

  depends_on 'setuptools'

  def self.install
    system "python setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end

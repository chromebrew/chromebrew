require 'buildsystems/pip'

class Aws_shell < Pip
  description 'An integrated shell for working with the AWS CLI.'
  homepage 'https://github.com/awslabs/aws-shell'
  version '0.2.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d42cc152c167d666135d73764fef7d7451b2d176f6049b6725769651406cbe6',
     armv7l: '0d42cc152c167d666135d73764fef7d7451b2d176f6049b6725769651406cbe6',
       i686: 'c0d8ef802d2e77523d85456e76461c7ecb43a4f1e337437a4a38127174827eb0',
     x86_64: '44e131d748002783bd0f391c564901a145f19a95b8088d9f61dbd4be5ca5bd44'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_nh3'
  depends_on 'python3' => :logical

  no_source_build

  def self.postinstall
    ExitMessage.add "\nType 'aws-shell' to get started.\n"
  end
end

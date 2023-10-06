require 'buildsystems/python'

class Py3_argcomplete < Python
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  @_ver = '3.1.2'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/kislyuk/argcomplete.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/3.1.2-py3.12_armv7l/py3_argcomplete-3.1.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/3.1.2-py3.12_armv7l/py3_argcomplete-3.1.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/3.1.2-py3.12_i686/py3_argcomplete-3.1.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/3.1.2-py3.12_x86_64/py3_argcomplete-3.1.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '20cc478c4305dfca682c2e49228b11965d5423b323d88c17b72c32fd97486ac7',
     armv7l: '20cc478c4305dfca682c2e49228b11965d5423b323d88c17b72c32fd97486ac7',
       i686: 'e9207b11af7766fbb6eb529a47d24c3a0f9bad100c6ac2f30a3e9976ada0aee8',
     x86_64: '101776a62bed162e0f67db5e36aebff9cef52c9369c07bd069425fe9c942a925'
  })

  depends_on 'python3' => :build
end

require 'package'

class Py3_argcomplete < Package
  description 'Argcomplete provides bash completion for argparse.'
  homepage 'https://kislyuk.github.io/argcomplete/'
  @_ver = '1.12.3'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/kislyuk/argcomplete.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3-py3.11_armv7l/py3_argcomplete-1.12.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3-py3.11_armv7l/py3_argcomplete-1.12.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3-py3.11_i686/py3_argcomplete-1.12.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_argcomplete/1.12.3-py3.11_x86_64/py3_argcomplete-1.12.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '489167be4453eebb3e8895ba59847afe157a780e385e3792c47d0a14d2ef0a1e',
     armv7l: '489167be4453eebb3e8895ba59847afe157a780e385e3792c47d0a14d2ef0a1e',
       i686: 'e283088168e336e52bb968066643fd2f7a19a4ff9ae326a020f1c87d7f094f07',
     x86_64: '1abfd335df19833406fa0fcfc1053ad70f87e7647034c825a18b72e7d7d41608'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

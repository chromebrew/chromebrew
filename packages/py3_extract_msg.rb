require 'package'

class Py3_extract_msg < Package
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  @_ver = '0.28.7'
  version "#{@_ver}-1"
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/67/fb/ed86f4fa53e58e90598f635bba9b4140a20992bd968aaaf8ae1fbacd6e57/extract_msg-0.28.7.tar.gz'
  source_sha256 '7ebdbd7863a3699080a69f71ec0cd30ed9bfee70bad9acc6a8e6abe9523c78c0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-1_armv7l/py3_extract_msg-0.28.7-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-1_armv7l/py3_extract_msg-0.28.7-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-1_i686/py3_extract_msg-0.28.7-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-1_x86_64/py3_extract_msg-0.28.7-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9aa5ab813fc356ac41c8ce9fabc7ed381e7049524ea6be7578af5c8c512a392c',
     armv7l: '9aa5ab813fc356ac41c8ce9fabc7ed381e7049524ea6be7578af5c8c512a392c',
       i686: '97811b1d2e2c76396de636c348913218d42096184a87010839cc1a85820fae6a',
     x86_64: 'de6c5055b5bc9dc212878c3296130475e974121f987a8f8b886645fde5f9a72c'
  })

  depends_on 'py3_tzlocal'
  depends_on 'py3_olefile'
  depends_on 'py3_imapclient'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

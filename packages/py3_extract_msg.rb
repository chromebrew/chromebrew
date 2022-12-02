require 'package'

class Py3_extract_msg < Package
  description 'Extract-msg extracts emails and attachments saved in Microsoft Outlook\'s .msg files.'
  homepage 'https://github.com/mattgwwalker/msg-extractor/'
  @_ver = '0.28.7'
  version "#{@_ver}-py3.11"
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/67/fb/ed86f4fa53e58e90598f635bba9b4140a20992bd968aaaf8ae1fbacd6e57/extract_msg-0.28.7.tar.gz'
  source_sha256 '7ebdbd7863a3699080a69f71ec0cd30ed9bfee70bad9acc6a8e6abe9523c78c0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-py3.11_armv7l/py3_extract_msg-0.28.7-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-py3.11_armv7l/py3_extract_msg-0.28.7-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-py3.11_i686/py3_extract_msg-0.28.7-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-py3.11_x86_64/py3_extract_msg-0.28.7-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fc38c2f4143209ca8e75b65699c421eb9b6479c523863686b9e873786b55c0db',
     armv7l: 'fc38c2f4143209ca8e75b65699c421eb9b6479c523863686b9e873786b55c0db',
       i686: 'b53105bb06fa359d511283b805bc4dba2c1a4223677c392c1200073cc2de761e',
     x86_64: '124e8f468060ef17171945f3409d513ad405e0b21b41f311973a86b94603d195'
  })

  depends_on 'py3_tzlocal'
  depends_on 'py3_olefile'
  depends_on 'py3_imapclient'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

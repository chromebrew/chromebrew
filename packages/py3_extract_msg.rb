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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7_armv7l/py3_extract_msg-0.28.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7_armv7l/py3_extract_msg-0.28.7-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-1_i686/py3_extract_msg-0.28.7-1-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_extract_msg/0.28.7-1_x86_64/py3_extract_msg-0.28.7-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c2b94eba0e922d79cd416c77db71e8004422efe69e90f306e5ae8b196d4a6446',
     armv7l: 'c2b94eba0e922d79cd416c77db71e8004422efe69e90f306e5ae8b196d4a6446',
    i686: '547edeadfe7fc86e32ad45b720911ceb32284d8f54c8ed60d7eed33a7914b062',
  x86_64: 'fc217ba3dc3944152c4a9f324203ec2a1c482997893a2f704769433295d583e7'
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

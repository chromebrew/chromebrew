require 'package'

class Py3_prompt_toolkit < Package
  description 'Prompt-toolkit is a library for building powerful interactive command lines in Python'
  homepage 'https://python-prompt-toolkit.readthedocs.io/'
  version '3.0.18'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/prompt-toolkit/python-prompt-toolkit/archive/3.0.18.tar.gz'
  source_sha256 '5d40da3602fe324d660b108ee0535a8d83f0fed5b8836e30e2f086c135cfda07'

  depends_on 'py3_six'
  depends_on 'py3_wcwidth'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end

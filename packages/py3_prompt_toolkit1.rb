require 'package'

class Py3_prompt_toolkit1 < Package
  description 'Prompt-toolkit is a library for building powerful interactive command lines in Python'
  homepage 'https://python-prompt-toolkit.readthedocs.io/'
  version '1.0.18'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/prompt-toolkit/python-prompt-toolkit/archive/1.0.18.tar.gz'
  source_sha256 '2528ee342cc278326aadd04aadf08dff1c38e91f9d4c8a202122e2cdc5c8b405'

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

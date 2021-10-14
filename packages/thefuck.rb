require 'package'

class Thefuck < Package
  description 'Thef*ck is a magnificent app which corrects your previous console command.'
  homepage 'https://github.com/nvbn/thefuck/'
  @_ver = '3.31'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nvbn/thefuck.git'
  git_hashtag @_ver

  depends_on 'py3_six'
  depends_on 'py3_colorama'
  depends_on 'py3_psutil'
  depends_on 'py3_pyte'
  depends_on 'py3_decorator'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

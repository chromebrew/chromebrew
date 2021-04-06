require 'package'

class Thefuck < Package
  description 'TheF*ck is a magnificent app which corrects your previous console command.'
  homepage 'https://github.com/nvbn/thefuck/'
  version '3.30'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nvbn/thefuck/archive/3.30.tar.gz'
  source_sha256 'dd2e7bc94e9453beabbafc10c4d62c67601ea705250103a67ababcdad2991dd3'

  depends_on 'py3_colorama'
  depends_on 'py3_decorator'
  depends_on 'py3_psutil'
  depends_on 'py3_pyte'
  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end

  def self.postinstall
    system 'fuck'
  end
end

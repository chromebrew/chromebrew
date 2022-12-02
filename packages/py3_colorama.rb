require 'package'

class Py3_colorama < Package
  description 'Colorama makes ANSI color sequences work on MS Windows.'
  homepage 'https://github.com/tartley/colorama/'
  @_ver = '0.4.4'
  version "#{@_ver}-py3.11"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/tartley/colorama.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-py3.11_armv7l/py3_colorama-0.4.4-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-py3.11_armv7l/py3_colorama-0.4.4-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-py3.11_i686/py3_colorama-0.4.4-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_colorama/0.4.4-py3.11_x86_64/py3_colorama-0.4.4-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8a8ddc121b37b78807e6d56193179d3a1e4928d51a4075ee4c6748f28ca74554',
     armv7l: '8a8ddc121b37b78807e6d56193179d3a1e4928d51a4075ee4c6748f28ca74554',
       i686: 'a4ceb8b2c07195fd35ab283422028dbe241ed931813e5b7257f443664325b49b',
     x86_64: '423d4464df9bacce84bf757b109983801e49664b4511ccf06b5552961511a84a'
  })

  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end

require 'buildsystems/meson'
Package.load_package("#{__dir__}/py3_pycairo.rb")

class Py3cairo < Meson
  description Py3_pycairo.description
  homepage Py3_pycairo.homepage
  version Py3_pycairo.version
  license Py3_pycairo.license
  compatibility Py3_pycairo.compatibility
  source_url 'https://github.com/pygobject/pycairo.git'
  git_hashtag "v#{version.gsub("-#{CREW_PY_VER}", '')}"
  binary_compression 'tar.zst'

  depends_on 'cairo' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_pycairo' => :logical

  conflicts_ok
end

require 'buildsystems/pip'

class Py3_tomli_w < Pip
  description "Tomli-w is a lil' TOML writer."
  homepage 'https://github.com/hukkin/tomli-w/'
  @_ver = '1.0.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
end

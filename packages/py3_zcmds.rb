require 'buildsystems/pip'

class Py3_zcmds < Pip
  description 'Cross platform(ish) productivity commands written in python'
  homepage 'https://github.com/zackees/zcmds'
  version '1.4.100-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  no_compile_needed
end

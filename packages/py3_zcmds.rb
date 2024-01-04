require 'buildsystems/python'

class Py3_zcmds < Python
  description 'Cross platform(ish) productivity commands written in python'
  homepage 'https://github.com/zackees/zcmds'
  @_ver = '1.1.18-1c3965'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/zackees/zcmds.git'
  git_hashtag '1c396504a1756b220d028115defc1b87f584eed3'

  no_compile_needed
end

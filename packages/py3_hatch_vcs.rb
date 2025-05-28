require 'buildsystems/pip'

class Py3_hatch_vcs < Pip
  description 'A plugin for Hatch that uses your preferred version control system.'
  homepage 'https://github.com/ofek/hatch-vcs'
  version "0.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82720a22aa2441ea0ef5ae2067f10434d19016c6f56695f97b373795b5dd698d',
     armv7l: '82720a22aa2441ea0ef5ae2067f10434d19016c6f56695f97b373795b5dd698d',
       i686: 'fe36a395d4241cf1a852fc16bdc8766e8a9c1999f6d92a041c6aa74c9bd16f5e',
     x86_64: '8898727e03e8de16f7bdaab6e79f98cf4198489660280927a82ea83ba4e817af'
  })

  depends_on 'python3' => :build

  no_source_build
end

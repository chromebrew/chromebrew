require 'buildsystems/pip'

class Py3_hatch_vcs < Pip
  description 'A plugin for Hatch that uses your preferred version control system.'
  homepage 'https://github.com/ofek/hatch-vcs'
  @_ver = '0.3.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatch_vcs/0.3.0-py3.12_armv7l/py3_hatch_vcs-0.3.0-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatch_vcs/0.3.0-py3.12_armv7l/py3_hatch_vcs-0.3.0-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatch_vcs/0.3.0-py3.12_i686/py3_hatch_vcs-0.3.0-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_hatch_vcs/0.3.0-py3.12_x86_64/py3_hatch_vcs-0.3.0-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bee86304be18a8747ef8e32b9de44ab1ab4b4dfec69cc4723a145d00538b7c89',
     armv7l: 'bee86304be18a8747ef8e32b9de44ab1ab4b4dfec69cc4723a145d00538b7c89',
       i686: 'b988e58431e88ef6a6fc5f758d0aff1a479c6f58e1255f7a0eaec83f28d65a95',
     x86_64: '058612a6da169b90366290041679ffddef963cb1d0b29d6eb079d05213f1dc63'
  })

  depends_on 'python3' => :build
end

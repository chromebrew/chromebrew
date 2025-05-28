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
    aarch64: '98c77ad86a6a74c0911875fdfad823bd2d5d85ec3b4c4b6eb0903023cf3aafb4',
     armv7l: '98c77ad86a6a74c0911875fdfad823bd2d5d85ec3b4c4b6eb0903023cf3aafb4',
       i686: '16aa11be9f229a8cd029f01e30344bababc1fc84df3f31339f3949864b364bee',
     x86_64: '89166c75ba56df60564258a6c9323e0eb5b0e99f25c220f5765530db9901fea4'
  })

  depends_on 'python3' => :build

  no_source_build
end

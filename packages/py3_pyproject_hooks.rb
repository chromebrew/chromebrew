require 'buildsystems/pip'

class Py3_pyproject_hooks < Pip
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  version "1.3.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b8a6cb73dd08980f16c67bcfa9dc3077e302d7d6347b8db62af5f5d46fe223d7',
     armv7l: 'b8a6cb73dd08980f16c67bcfa9dc3077e302d7d6347b8db62af5f5d46fe223d7',
       i686: 'ca6721908cf361b6065cd5b694ff6891aca7ce79a32bd8cfce300f709f2f1598',
     x86_64: 'c8977d95ec4b725914fd160546050137b38e868b5cc0372ce99e0c28e4a56beb'
  })

  depends_on 'py3_tomli'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end

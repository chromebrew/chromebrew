require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.5.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf478a0e61727574b3d21cd95a3670ba50c326f8c832a4dea8e323331fa8aebb',
     armv7l: 'bf478a0e61727574b3d21cd95a3670ba50c326f8c832a4dea8e323331fa8aebb',
       i686: 'e3811e87908d17fb83f144d8ea625244a857ffa395f18217c0300826b822b75a',
     x86_64: '86de2d28369a726dd667d78c4554b5e0583b976e69bd1af2c96c35593b31f6ce'
  })

  depends_on 'py3_cryptography'
  depends_on 'py3_jinja2'
  depends_on 'py3_packaging'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :logical
  depends_on 'xdg_base'

  no_source_build

  def self.postremove
    Package.agree_to_remove("#{HOME}/.ansible")
  end
end

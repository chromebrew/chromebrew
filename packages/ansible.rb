require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "13.6.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '866ac15655428076dcb68f6319ec8ca76ca477a659fc47e76c379bba72fad1ca',
     armv7l: '866ac15655428076dcb68f6319ec8ca76ca477a659fc47e76c379bba72fad1ca',
       i686: '3721ddd3411aa56dafec87684c989daca48f693737574ca263905a085f4b2960',
     x86_64: '6bb4eb57019ed59a51980a0cc37d30873df76cbbb4fade9eb4c693edbbc4da1d'
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

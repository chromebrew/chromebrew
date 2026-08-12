require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.3.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '744e2659c3638e5d27b0cbd110697ef9ddee1431f6ef589ce2ec4f5b09d38c69',
     armv7l: '744e2659c3638e5d27b0cbd110697ef9ddee1431f6ef589ce2ec4f5b09d38c69',
       i686: '9fa42ff360cc4b81b3744ee59661556d16904653f299e56a71656b74f1c13f24',
     x86_64: '5f723c547fc028d33d7e234e104fbc21c45655a7bc0bb8040ddd4b3f68fae247'
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

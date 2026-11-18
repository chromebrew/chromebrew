require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "15.0.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a08ff9540dfae1e06f1a18ed6031264b5364edc8f7ab6eaab88ff7431df4a61',
     armv7l: '9a08ff9540dfae1e06f1a18ed6031264b5364edc8f7ab6eaab88ff7431df4a61',
       i686: '5d392a09d8a5d3f0b87c20fcb8047680b41b8f45ac65fa72ab62647851a292d0',
     x86_64: '1e9fcab9c827ca704a20b9bbf2ea6cec375591a915aec26c9d1790dbdfc6d520'
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

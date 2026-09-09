require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.4.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '13b3dd0f98052191977d08aae9f484171610a800f1384ca7df5725c3471faa3d',
     armv7l: '13b3dd0f98052191977d08aae9f484171610a800f1384ca7df5725c3471faa3d',
       i686: '8e749d4fba7008750e755f957e18483e0a7e0df8e74446e20ad25ca1a44d7de9',
     x86_64: 'f4d3358c4274b3deb2a610cf99b5ee91006465fc7a4d2c4771e05553438f76fb'
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

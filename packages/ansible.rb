require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "14.2.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c343f7156819c88d1a28fea6e94ed1047ef41bb947c6e368629313fd7730a98f',
     armv7l: 'c343f7156819c88d1a28fea6e94ed1047ef41bb947c6e368629313fd7730a98f',
       i686: 'a95227771b583fd36126114df43d8922f876a1daf8495b43ddb05caa88216222',
     x86_64: '1dbaa186763091a20f35a8f79431f9c45546e2ea867012ecc9b8ec7f0f0f5895'
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

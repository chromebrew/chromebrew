require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "13.3.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba343239cbfaeb4b8d363cf666d8a66fc9c66f27aecfbbd637c5ca2cc6958578',
     armv7l: 'ba343239cbfaeb4b8d363cf666d8a66fc9c66f27aecfbbd637c5ca2cc6958578',
       i686: '25fec96c078d8b2d3b4f293a9fc00568ff15994e59bd8f46b8aaf39645d6e024',
     x86_64: '6c9ebc4fea19cc9167abefc7232084af72edbd4e7ee549b8ed78001f2538a0ec'
  })

  depends_on 'xdg_base'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyyaml'
  depends_on 'py3_packaging'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build

  def self.postremove
    Package.agree_to_remove("#{HOME}/.ansible")
  end
end

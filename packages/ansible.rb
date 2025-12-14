require 'buildsystems/pip'

class Ansible < Pip
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version "13.1.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e26ef8be53718de60c1dca6104a2f636467c50a16ec2a59a3a99618ffa12272e',
     armv7l: 'e26ef8be53718de60c1dca6104a2f636467c50a16ec2a59a3a99618ffa12272e',
       i686: 'dbd72736acb3866e6f9f5e5054843e749c7475502781f9b5e446f33a216fa0d5',
     x86_64: 'f86c047074b0824cc6481d6da2c7311ac91202707f989abdd3a85d8b69b76fc4'
  })

  depends_on 'xdg_base'
  depends_on 'py3_cryptography'
  depends_on 'py3_pyyaml'
  depends_on 'py3_packaging'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end

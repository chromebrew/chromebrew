require 'package'

class Docker_systemctl_replacement < Package
  description 'docker systemctl replacement'
  homepage 'https://github.com/gdraheim/docker-systemctl-replacement'
  version '9cbe1a0'
  license 'EUPL'
  compatibility 'all'
  source_url 'https://github.com/gdraheim/docker-systemctl-replacement.git'
  git_hashtag '9cbe1a00eb4bdac6ff05b96ca34ec9ed3d8fc06c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker_systemctl_replacement/9cbe1a0_armv7l/docker_systemctl_replacement-9cbe1a0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker_systemctl_replacement/9cbe1a0_armv7l/docker_systemctl_replacement-9cbe1a0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker_systemctl_replacement/9cbe1a0_i686/docker_systemctl_replacement-9cbe1a0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker_systemctl_replacement/9cbe1a0_x86_64/docker_systemctl_replacement-9cbe1a0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '018be1e2684c084bd58f80fb1a52e417c430712ea956c89bcc17d82bab472947',
     armv7l: '018be1e2684c084bd58f80fb1a52e417c430712ea956c89bcc17d82bab472947',
       i686: 'f72bbcc62a4ac6801d8603efd6fc19d2ac64d0f3de881fde49c7047575463054',
     x86_64: '210280e690f7665396ea98b87af324095b3abd34e40ab904ad3ee5214a4bfbb2'
  })

  depends_on 'python3'

  def self.patch
    system "sed -i 's,/usr/bin/python3,#{CREW_PREFIX}/bin/python3,g' files/docker/systemctl3.py"
  end

  def self.install
    # Systemd units should go in "{XDG_CONFIG_HOME}/systemd/user"
    # Units can be accessed via "systemctl status --user unitname"
    FileUtils.mkdir_p %W[
      #{CREW_DEST_PREFIX}/bin
      #{CREW_DEST_PREFIX}/.config/systemd/user
    ]
    FileUtils.install 'files/docker/systemctl3.py', "#{CREW_DEST_PREFIX}/bin/systemctl", mode: 0o755
  end
end

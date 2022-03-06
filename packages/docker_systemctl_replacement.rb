require 'package'

class Docker_systemctl_replacement < Package
  description 'docker systemctl replacement'
  homepage 'https://github.com/gdraheim/docker-systemctl-replacement'
  version '9cbe1a0'
  license 'EUPL'
  compatibility 'all'
  source_url 'https://github.com/gdraheim/docker-systemctl-replacement.git'
  git_hashtag '9cbe1a00eb4bdac6ff05b96ca34ec9ed3d8fc06c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker_systemctl_replacement/9cbe1a0_armv7l/docker_systemctl_replacement-9cbe1a0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker_systemctl_replacement/9cbe1a0_armv7l/docker_systemctl_replacement-9cbe1a0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker_systemctl_replacement/9cbe1a0_i686/docker_systemctl_replacement-9cbe1a0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/docker_systemctl_replacement/9cbe1a0_x86_64/docker_systemctl_replacement-9cbe1a0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '66715b93dee98fd66b2fd9c7452290923b2675d5a4793f5b66e6ae6dc9325962',
     armv7l: '66715b93dee98fd66b2fd9c7452290923b2675d5a4793f5b66e6ae6dc9325962',
       i686: '86175ac25ede6fb8e31bbc419ae0177b3acf41fd3f9e513744ccaf4418255260',
     x86_64: '56f4b32b29628ea1ab280b5c81a186f8f9fd83c114282858b7cced24324f13cf'
  })

  depends_on 'python3'
  no_fhs

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

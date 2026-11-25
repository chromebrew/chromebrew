require 'package'

class Gitlab_runner < Package
  description 'Run your CI/CD jobs and send the results back to GitLab'
  homepage 'https://gitlab.com/gitlab-org/gitlab-runner'
  version '19.6.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
     armv7l: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
       i686: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-386",
     x86_64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-amd64"
  })
  source_sha256({
    aarch64: '7ba259f6b84bdd6b915b479a8ba39112bff9282aae7a68c56235727ae9fd4e2c',
     armv7l: '7ba259f6b84bdd6b915b479a8ba39112bff9282aae7a68c56235727ae9fd4e2c',
       i686: 'dd9c4ea94c9e048ae91bdf7007ff236e773c6f59c62a43f8e2d9ccd476da4009',
     x86_64: '9a2c76ff287ce55466fdbc2590fea700ac822515556c2fc6fbda8749eefe2fc0'
  })

  no_compile_needed
  no_shrink

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm'
    when 'i686'
      arch = '386'
    when 'x86_64'
      arch = 'amd64'
    end
    FileUtils.install "gitlab-runner-linux-#{arch}", "#{CREW_DEST_PREFIX}/bin/gitlab-runner", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'gitlab-runner -h' to get started.\n"
  end
end

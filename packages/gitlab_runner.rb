require 'package'

class Gitlab_runner < Package
  description 'Run your CI/CD jobs and send the results back to GitLab'
  homepage 'https://gitlab.com/gitlab-org/gitlab-runner'
  version '19.4.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
     armv7l: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
       i686: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-386",
     x86_64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-amd64"
  })
  source_sha256({
    aarch64: 'fd7558b281c9c10c78fde40f28fb8e5e2bce02f69e6d51a4d5899c1c3582825a',
     armv7l: 'fd7558b281c9c10c78fde40f28fb8e5e2bce02f69e6d51a4d5899c1c3582825a',
       i686: 'd6c65ed574a1f154c7067654ba5752b4a855079313cb0c27a4fd8d0159ab311f',
     x86_64: 'aeebda6435d006622f135e4b095450446e1077d8980227a44b53fc404fc22157'
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

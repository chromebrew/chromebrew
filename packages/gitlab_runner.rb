require 'package'

class Gitlab_runner < Package
  description 'Run your CI/CD jobs and send the results back to GitLab'
  homepage 'https://gitlab.com/gitlab-org/gitlab-runner'
  version '19.1.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
     armv7l: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
       i686: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-386",
     x86_64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-amd64"
  })
  source_sha256({
    aarch64: '429942b3e71b8972172f76bfc74e37496b3d2cf02aba2fda8e2358ad43cdb11e',
     armv7l: '429942b3e71b8972172f76bfc74e37496b3d2cf02aba2fda8e2358ad43cdb11e',
       i686: '0832f1099d32d135bb523461dc4aab577f53d48cb0bf3411753e4c6ad03c2388',
     x86_64: '8c8ea572b9f0d40e93b876b90c7d093eb403a41bbadbbf9a0fcf27b6b75c2800'
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

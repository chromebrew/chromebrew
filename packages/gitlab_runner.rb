require 'package'

class Gitlab_runner < Package
  description 'Run your CI/CD jobs and send the results back to GitLab'
  homepage 'https://gitlab.com/gitlab-org/gitlab-runner'
  version '19.2.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
     armv7l: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
       i686: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-386",
     x86_64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-amd64"
  })
  source_sha256({
    aarch64: '04a6a72e723b5c9c74ecbb7b147e29d26652bd075bf483632685f8c07d728b0f',
     armv7l: '04a6a72e723b5c9c74ecbb7b147e29d26652bd075bf483632685f8c07d728b0f',
       i686: '1934b52500b619cef1ef04610ae389dd1eca63fd27f7b7bc9a96aafceb71db37',
     x86_64: '20401d7e35e01e1629c3351289acd6ca969d2c3ac1292eec5b7612e9803f5c9c'
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

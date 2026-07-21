require 'package'

class Gitlab_runner < Package
  description 'Run your CI/CD jobs and send the results back to GitLab'
  homepage 'https://gitlab.com/gitlab-org/gitlab-runner'
  version '19.2.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
     armv7l: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-arm",
       i686: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-386",
     x86_64: "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/v#{version}/binaries/gitlab-runner-linux-amd64"
  })
  source_sha256({
    aarch64: '48c95fb0019b46b4c7d23cbd5ff901cf8501eff875c92dfcf68d0a1960b579f6',
     armv7l: '48c95fb0019b46b4c7d23cbd5ff901cf8501eff875c92dfcf68d0a1960b579f6',
       i686: '1afaf86d03344ce1c383ffcee6c0c2e3e54af112a484b5dfa4f274b50012ed8e',
     x86_64: '0ef0d1c4435ffcf7da361b0b8219aac6da8ff1caaf276f11b893e9adb60b19d6'
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

require 'package'

class Gcloud < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/gcloud/'
  version '512.0.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-linux-arm.tar.gz",
     armv7l: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-linux-arm.tar.gz",
       i686: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-linux-x86.tar.gz",
     x86_64: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-linux-x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'bd3437e72ab65f71b4642d80e52bf848852d0b8e6b4db820cfdbf2eae260139c',
     armv7l: 'bd3437e72ab65f71b4642d80e52bf848852d0b8e6b4db820cfdbf2eae260139c',
       i686: 'd7d473a99adf2fe80e49b3d58be0a1491a2c882add4af9f219ca5139002931c2',
     x86_64: '4ffb7c601a7ed29d6aa2611c7cf6f7e24daae1c421e9267df97d7f5449acd4e7'
  })

  depends_on 'python3'
  depends_on 'xdg_base'

  no_shrink
  no_compile_needed
  print_source_bashrc

  def self.build
    @gcloudenv = <<~EOF

      # The next line updates PATH for the Google Cloud SDK.
      if [ -f '#{CREW_PREFIX}/share/gcloud/path.bash.inc' ]; then . '#{CREW_PREFIX}/share/gcloud/path.bash.inc'; fi

      # The next line enables shell command completion for gcloud.
      if [ -f '#{CREW_PREFIX}/share/gcloud/completion.bash.inc' ]; then . '#{CREW_PREFIX}/share/gcloud/completion.bash.inc'; fi
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/gcloud"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gcloud"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/gcloud"
    FileUtils.cd "#{CREW_DEST_PREFIX}/share/gcloud" do
      system "./install.sh \
              --usage-reporting false \
              --rc-path #{HOME}/.bashrc \
              --quiet"
    end
    Dir.mkdir "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/share/gcloud/bin" do
      system "find -type f -maxdepth 1 -exec ln -s #{CREW_PREFIX}/share/gcloud/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
    FileUtils.mv "#{HOME}/.bashrc.backup", "#{HOME}/.bashrc"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/gcloud", @gcloudenv
  end

  def self.postinstall
    ExitMessage.add <<~EOM
      To finish the installation, execute the following:
      gcloud init
    EOM
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.config/gcloud")
    Package.agree_to_remove("#{CREW_PREFIX}/share/gcloud")
  end
end

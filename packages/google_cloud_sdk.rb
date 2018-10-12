require 'package'

class Google_cloud_sdk < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/'
  version '220.0.0'

  case ARCH
  when 'i686'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-220.0.0-linux-x86.tar.gz'
    source_sha256 'd347562e5a076330f96506285c01e9c9f6e594524c54e02842da7e63bdfe264d'
  when 'x86_64'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-220.0.0-linux-x86_64.tar.gz'
    source_sha256 'a2205e35b11136004d52d47774762fbec9145bf0bda74ca506f52b71452c570e'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'xdg_base'

  def self.install
    FileUtils.mkdir_p "#{ENV['HOME']}/.config/gcloud"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/gcloud"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/google_cloud_sdk"
    system "cp -r . #{CREW_DEST_PREFIX}/share/google_cloud_sdk"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/google_cloud_sdk") do
      system "./install.sh \
              --usage-reporting false \
              --rc-path $HOME/.bashrc \
              --quiet"
    end
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/google_cloud_sdk/bin") do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/google_cloud_sdk/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
    end
    system "sed -i 's,#{CREW_DEST_DIR},,g' #{ENV['HOME']}/.bashrc"
    system "touch #{CREW_DEST_HOME}/.config/gcloud/config_sentinel"
    system "touch #{CREW_DEST_HOME}/.config/gcloud/gce"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "exec -l \$SHELL".lightblue
    puts "gcloud init".lightblue
    puts
  end
end

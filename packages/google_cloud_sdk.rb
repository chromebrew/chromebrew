require 'package'

class Google_cloud_sdk < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/'
  version '228.0.0'

  case ARCH
  when 'i686'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-228.0.0-linux-x86.tar.gz'
    source_sha256 '24f5909f3928384150883a8e33447f3a6881a846fedacdd2dbe5af308e915f76'
  when 'x86_64'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-228.0.0-linux-x86_64.tar.gz'
    source_sha256 'e4876cedf2af338a0c853f4cf97aa88e18173117ed4f59c93c9d25239ac3ade3'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'xdg_base'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/gcloud"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/google_cloud_sdk"
    system "cp -a . #{CREW_DEST_PREFIX}/share/google_cloud_sdk"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/google_cloud_sdk") do
      system "./install.sh \
              --usage-reporting false \
              --rc-path #{ENV['HOME']}/.bashrc \
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

require 'package'

class Google_cloud_sdk < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/'
  version '236.0.0'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-236.0.0-linux-x86.tar.gz'
    source_sha256 '6ea8595dff4926318e408879ef2ac46329b470d6ed76010ae19bfa6aaad5cdee'
  when 'x86_64'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-236.0.0-linux-x86_64.tar.gz'
    source_sha256 'cfa7ff7c67d58d5b1bd2ae623a007c23d94937d8bc898b7933c647c660860659'
  end

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'xdg_base'
  end

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

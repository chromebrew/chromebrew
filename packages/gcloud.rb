require 'package'

class Gcloud < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/gcloud/'
  version '346.0.0'
  license 'Apache-2.0'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-346.0.0-linux-x86.tar.gz'
    source_sha256 '6097612773d139b178b743013cbdc6f708c84d55c95d1674eb0da87c922d3df3'
  when 'x86_64'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-346.0.0-linux-x86_64.tar.gz'
    source_sha256 '9d21569ecd66e4278c45594e3ce10fcb2591704756aeb2b0f04bed14f86f9658'
  end

  depends_on 'xdg_base'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/gcloud"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gcloud"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/gcloud"
    FileUtils.cd("#{CREW_DEST_PREFIX}/share/gcloud") do
      system "./install.sh \
              --usage-reporting false \
              --rc-path #{HOME}/.bashrc \
              --quiet"
    end
    system "sed -i 's,#{CREW_DEST_DIR},,g' #{HOME}/.bashrc"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "exec -l \$SHELL".lightblue
    puts "#{CREW_PREFIX}/share/gcloud/bin/gcloud init".lightblue
    puts
  end

  def self.remove
    print "Would you like to remove the config directories? [y/N] "
    response = STDIN.getc
    config_dirs = ["#{HOME}/.config/gcloud", "#{CREW_PREFIX}/share/gcloud"]
    config_dirs.each { |config_dir|
      if Dir.exists? config_dir
        case response
        when "y", "Y"
          FileUtils.rm_rf config_dir
          puts "#{config_dir} removed.".lightred
        else
          puts "#{config_dir} saved.".lightgreen
        end
      end
    }
  end
end

require 'package'

class Gcloud < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/gcloud/'
  version '341.0.0'
  license 'Apache-2.0'
  compatibility 'i686,x86_64'
  case ARCH
  when 'i686'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-341.0.0-linux-x86.tar.gz'
    source_sha256 'acb8ebd47a23b7cf343e08e36e91fa05bfe7be31160cf699dbc0f2d2e7d3e8a8'
  when 'x86_64'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-341.0.0-linux-x86_64.tar.gz'
    source_sha256 'baafb8415d0d1c909c229ad704b1b05de57e10cddabc4fdf8018db4bcf02ab45'
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

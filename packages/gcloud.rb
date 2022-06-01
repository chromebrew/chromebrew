require 'package'

class Gcloud < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/gcloud/'
  version '374.0.0'
  license 'Apache-2.0'
  compatibility 'i686,x86_64'
  source_url ({
      i686: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-#{version}-linux-x86.tar.gz",
    x86_64: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-#{version}-linux-x86_64.tar.gz",
  })
  source_sha256 ({
      i686: '4fdd248b2235a82e829a7929822d15a94b8a652ecf9b231a4f7061bb98c9bbd6',
    x86_64: 'ceaa3eb7147ed061280e30322f7c78f61749b953c9450a2df2035a145f016b7e',
  })

  depends_on 'xdg_base'

  def self.build
    @gcloudenv = <<~EOF

      # The next line updates PATH for the Google Cloud SDK.
      if [ -f '#{CREW_PREFIX}/share/gcloud/path.bash.inc' ]; then . '#{CREW_PREFIX}/share/gcloud/path.bash.inc'; fi

      # The next line enables shell command completion for gcloud.
      if [ -f '#{CREW_PREFIX}/share/gcloud/completion.bash.inc' ]; then . '#{CREW_PREFIX}/share/gcloud/completion.bash.inc'; fi
    EOF
  end

  def self.install
    ENV['CREW_NOT_SHRINK_ARCHIVE'] = '1'
    reload_constants
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
    IO.write "#{CREW_DEST_PREFIX}/etc/env.d/gcloud", @gcloudenv
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "source ~/.bashrc && gcloud init".lightblue
    puts
  end

  def self.remove
    print "Would you like to remove the config directories? [y/N] "
    response = STDIN.getc
    config_dirs = ["#{HOME}/.config/gcloud", "#{CREW_PREFIX}/share/gcloud"]
    config_dirs.each { |config_dir|
      if Dir.exist? config_dir
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

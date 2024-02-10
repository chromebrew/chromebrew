require 'package'

class Gcloud < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/gcloud/'
  version '463.0.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-463.0.0-linux-arm.tar.gz',
     armv7l: 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-463.0.0-linux-arm.tar.gz',
       i686: 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-463.0.0-linux-x86.tar.gz',
     x86_64: 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-463.0.0-linux-x86_64.tar.gz'
  })
  source_sha256({
    aarch64: '41cde0aa0050e842eb19846f5ab89aae532c8080dbcd844e6a89e6a3865f4499',
     armv7l: '41cde0aa0050e842eb19846f5ab89aae532c8080dbcd844e6a89e6a3865f4499',
       i686: '780ca14ff9aa1c5258b5030238e2c471da88c5b1e08f80e4e201daaf1ab01111',
     x86_64: 'aa9d83d0736422da011d1e22c2a453d40ea3e0594fa676380d59be10fc184ce6'
  })

  depends_on 'python3'
  depends_on 'xdg_base'

  no_shrink
  no_compile_needed

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
    puts "\nTo finish the installation, execute the following:".lightblue
    puts "source ~/.bashrc && gcloud init\n".lightblue
  end

  def self.remove
    print 'Would you like to remove the config directories? [y/N] '
    response = $stdin.gets.chomp.downcase
    config_dirs = ["#{HOME}/.config/gcloud", "#{CREW_PREFIX}/share/gcloud"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir

      case response
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end

require 'package'

class Gcloud < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/gcloud/'
  version '488.0.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url({
    aarch64: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-linux-arm.tar.gz",
     armv7l: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-linux-arm.tar.gz",
       i686: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-linux-x86.tar.gz",
     x86_64: "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-#{version}-linux-x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'ce60e6847507ab917cf00e609de499aeda004e649c71f8ac4d9a47955e52f9f1',
     armv7l: 'ce60e6847507ab917cf00e609de499aeda004e649c71f8ac4d9a47955e52f9f1',
       i686: '9f88b9fff4945c639b9a307ced11d083da6debcaf583ee0e532de7da66f438b0',
     x86_64: 'a9129eb385d74b93e8548ffd5e5697e426b174a20bd399aa1ba850bf4f3f3c58'
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

  def self.postremove
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

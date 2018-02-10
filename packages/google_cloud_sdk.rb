require 'package'

class Google_cloud_sdk < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/'
  version '188.0.1'

  case ARCH
  when 'i686'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-188.0.1-linux-x86.tar.gz'
    source_sha256 '5ac86acadcecb050c12f0b166fede71441c90415f3b794860764894deb451949'
  when 'x86_64'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-188.0.1-linux-x86_64.tar.gz'
    source_sha256 '2966e8c21b4176037cc7f1916a170f2b6c7fcdb563cde25e26063986d2bdc047'
  else
    puts 'Unable to install google_cloud_sdk.  Supported architectures include i686 and x86_64 only.'.lightred
  end

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/google_cloud_sdk-188.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/google_cloud_sdk-188.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '60d2def4626fe1b977a1f4719746e255426c8b6350fbc346dbd597293a768cae',
     x86_64: '328017c5c64b10cb2b9c561cb875037a1f9beff273cb9b6b77a6ee8342706e6b',
  })

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/share/google_cloud_sdk"
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
    system "sed -i 's,#{CREW_DEST_DIR},,g' $HOME/.bashrc"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute the following:".lightblue
    puts "exec -l \$SHELL".lightblue
    puts "gcloud init".lightblue
    puts
  end
end

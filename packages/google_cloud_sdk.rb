require 'package'

class Google_cloud_sdk < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/'
  version '179.0.0'

  case ARCH
  when 'i686'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-179.0.0-linux-x86.tar.gz'
    source_sha256 '9aa61b596fc7a247643bf42f5d2ce153d46da79b136f0723055ad1a2864aba46'
  when 'x86_64'
    source_url 'https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-179.0.0-linux-x86_64.tar.gz'
    source_sha256 '7852ec02a38453ed11707646123994e5714a8ffd7cf3b401f4c963aadba8ed14'
  else
    puts 'Unable to install google_cloud_sdk.  Supported architectures include i686 and x86_64 only.'.lightred
  end

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/google_cloud_sdk-179.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/google_cloud_sdk-179.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '86526b7704b3330813192bcc129b2714d2fddd74987a928f9893b1cc979c91d8',
     x86_64: 'e11d8bacee72c6059ed23d02d7d7ff0aa36b3e7f2f6aeebd204ea983cc5922c7',
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
      system "find . -exec ln -s #{CREW_PREFIX}/share/google_cloud_sdk/bin/{} #{CREW_DEST_PREFIX}/bin \\;"
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

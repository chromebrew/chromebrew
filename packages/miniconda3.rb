require 'package'

class Miniconda3 < Package
  description 'Anaconda is the world\'s most popular Python data science platform.'
  homepage 'https://conda.io/miniconda.html'
  version '5.0.1'
  source_url 'https://raw.githubusercontent.com/Anaconda-Platform/anaconda-project/adb2d443b805f2c6c53f989251cc1a2b13fc0d0e/README.md'
  source_sha256 'ec0bfe39423ca117ffcd17c154e3e5f6c81a28c4fb14c22dd5033f499a306362'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/miniconda3-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/miniconda3-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/miniconda3-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/miniconda3-5.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f39e37069874e57911e58024e63acdbe530b8b4a7cbf3197b86fd7a9f4855bd9',
     armv7l: 'f39e37069874e57911e58024e63acdbe530b8b4a7cbf3197b86fd7a9f4855bd9',
       i686: '3dc928dc63f119c92029213a92b244543e916c1ba239483a935ccac79da1b7b6',
     x86_64: 'f488aed6b483c82f42be176b07fd8398b302381d60c80a34f3e7569a2295812a',
  })

  depends_on 'python3'

  def self.install
    case ARCH
    when 'i686'
      system 'curl -Ls -o miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86.sh'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('miniconda.sh') ) == 'df552bb9046db1f4b68c048e2693dcf52f936de63481589fbaa23c4d161562cf'
    when 'x86_64'
      system 'curl -Ls -o miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh'
      abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('miniconda.sh') ) == '5551f01f436b6409d467412c33e12ecc4f43b5e029290870f8fdeca403c274e6'
    else
      puts "#{ARCH} architecture not supported.".lightred
    end
    case ARCH
    when 'i686','x86_64'
      system "bash miniconda.sh -b -p #{CREW_PREFIX}/share/miniconda3"
      system "mkdir -p #{CREW_DEST_PREFIX}/bin"
      FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
        system "echo '#!/bin/bash' > conda"
        system "echo 'cd #{CREW_PREFIX}/share/miniconda3' >> conda"
        system "echo 'bin/conda \"\$@\"' >> conda"
        system "chmod +x conda"
      end
      system "mkdir -p #{CREW_DEST_DIR}#{CREW_CONFIG_PATH}/meta"
      system "echo #{CREW_PREFIX}/bin/conda > #{CREW_DEST_DIR}#{CREW_CONFIG_PATH}/meta/miniconda3.filelist"
      system "find #{CREW_PREFIX}/share/miniconda3/ -type d -exec echo {} >> #{CREW_DEST_DIR}#{CREW_CONFIG_PATH}/meta/miniconda3.directorylist \\;"
      system "find #{CREW_PREFIX}/share/miniconda3/ -type f -exec echo {} >> #{CREW_DEST_DIR}#{CREW_CONFIG_PATH}/meta/miniconda3.filelist \\;"
      system "find #{CREW_PREFIX}/share/miniconda3/ -type l -exec echo {} >> #{CREW_DEST_DIR}#{CREW_CONFIG_PATH}/meta/miniconda3.filelist \\;"
    end
  end

  def self.postinstall
    puts
    puts "To completely remove miniconda3 and all installed packages, execute the following:".lightblue
    puts "crew remove miniconda3".lightblue
    puts "rm -rf #{CREW_PREFIX}/share/miniconda3".lightblue
    puts
  end
end

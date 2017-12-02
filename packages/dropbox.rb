require 'package'

class Dropbox < Package
  description 'Dropbox simplifies the way you create, share and collaborate.  Bring your photos, docs, and videos anywhere and keep your files safe.'
  homepage 'https://www.dropbox.com/'
  version '33.4.23'
  case ARCH
  when 'i686'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86-33.4.23.tar.gz'
    source_sha256 '27e1bfd3823bdab797b27614cb3b1761316da6a29a2b39505fa6d07a7b0c521f'
  when 'x86_64'
    source_url 'https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x86_64-33.4.23.tar.gz'
    source_sha256 'bf635cc4dad1094dc3c42cac6208c8a7ad791e9419f0873ac1cb75b0c3691a7d'
  else
    puts 'Unable to install dropboxd.  Supported architectures include i686 and x86_64 only.'.lightred
  end

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dropbox-33.4.23-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dropbox-33.4.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: 'b59f73d452cd7cc956a3107e99675a1cbfe4d3bb15d7fc5bb16c4d77f1e3875d',
     x86_64: '8759fad457f68f4d25cf9bf016d738db5d5ddee001fcc5b8fcdb6b199b004ded',
  })

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  end

  def self.build
    system "wget https://linux.dropbox.com/packages/dropbox.py"
    system "sed -i 's,~/.dropbox-dist,#{CREW_LIB_PREFIX}/dropbox,g' dropbox.py"
    system "echo '#!/bin/bash' > dropboxd"
    system "echo 'PWD=$(pwd)' >> dropboxd"
    system "echo 'cd #{CREW_LIB_PREFIX}/dropbox' >> dropboxd"
    system "echo './dropboxd' >> dropboxd"
    system "echo 'cd $PWD' >> dropboxd"
    system "chmod +x dropboxd"
    system "echo '#!/bin/bash' > dropbox"
    system "echo 'python #{CREW_PREFIX}/bin/dropbox.py \"$@\"' >> dropbox"
    system "chmod +x dropbox"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}/dropbox"
    system "cp -r .dropbox-dist/* #{CREW_DEST_LIB_PREFIX}/dropbox"
    system "cp dropbox.py #{CREW_DEST_PREFIX}/bin"
    system "cp dropboxd #{CREW_DEST_PREFIX}/bin"
    system "cp dropbox #{CREW_DEST_PREFIX}/bin"
  end

  def self.postinstall
    puts
    puts "To finish the installation, execute 'dropboxd'.".lightblue
    puts "Login to dropbox.com, highlight the url and paste into Chrome.".lightblue
    puts "Type Ctrl+C to exit dropboxd after linking your system.".lightblue
    puts "Execute 'dropbox start' and after synching is complete, files will be available in ~/Dropbox.".lightblue
    puts "Execute 'dropbox' to see the full list of available options.".lightblue
    puts
  end
end

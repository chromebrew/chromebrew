require 'package'

class Vagrant < Package
  description 'Vagrant is a tool for building and distributing development environments.'
  homepage 'https://www.vagrantup.com/'
  version '2.0.1'
  compatibility 'all'
  source_url 'https://github.com/hashicorp/vagrant/archive/v2.0.1.tar.gz'
  source_sha256 '212b91c45f60a825fcfc656424021e2550833778a6d4ebe13458676201a04eba'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vagrant-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vagrant-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vagrant-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vagrant-2.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c87a9597690114da4fc34cd0c8c2a6af0f9c1b0591d5dc1e98fa59fddbdc6768',
     armv7l: 'c87a9597690114da4fc34cd0c8c2a6af0f9c1b0591d5dc1e98fa59fddbdc6768',
       i686: '4f52401baa59d15382e491d8c95e5470482725d80aa2d9b661c78496a35266bc',
     x86_64: '4ba294be3189df94ffdf603e710ffe21b706f9e41466afac2e24566f9e64948d',
  })

  def self.install
    system "gem install bundle" unless File.exists? "#{CREW_PREFIX}/bin/bundle"
    system "bundle install"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
      system "echo '#!/bin/bash' > vagrant"
      system "echo 'cd #{CREW_PREFIX}/share/vagrant' >> vagrant"
      system "echo 'bundle exec vagrant \"\$@\"' >> vagrant"
      system "chmod +x vagrant"
    end
    system "sed -i '349,354d' templates/locales/en.yml"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/vagrant"
    system "cp -r . #{CREW_DEST_PREFIX}/share/vagrant"
  end
end

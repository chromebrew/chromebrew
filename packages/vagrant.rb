require 'package'

class Vagrant < Package
  description 'Vagrant is a tool for building and distributing development environments.'
  homepage 'https://www.vagrantup.com/'
  version '2.0.1'
  source_url 'https://github.com/hashicorp/vagrant/archive/v2.0.1.tar.gz'
  source_sha256 '212b91c45f60a825fcfc656424021e2550833778a6d4ebe13458676201a04eba'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ruby'

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

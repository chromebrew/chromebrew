require 'package'

class software < Package
  description '
         Warning
          
          / \
         / ! \
        /_____\      
       
         _______
        |.-----.|
        ||x . x||
        ||_.-._||
        `--)-(--`
       __[=== o]___
      |:::::::::::|\
      `-=========-`() we here are using .deb packages to install apps' 
        
  homepage 'https://packages.ubuntu.com/trusty/gnome/software-center'
  version '1.0 beta'
  source_url 'file:///dev/null'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'sommeiler'
  
depends_on 'aptdaemon'
depends_on 'gir1.2-glib-2.0'
depends_on 'gir1.2-gmenu-3.0'
depends_on 'GObject'
depends_on 'gir1.2-gtk-3.0'
depends_on 'GTK+'
depends_on 'gir1.2-webkit-3.0'
depends_on 'gvfs-backends'
depends_on 'humanity-icon-theme'
depends_on 'Humanity Icon theme'
depends_on 'iso-codes'
depends_on 'oneconf'
depends_on 'policykit-1'
depends_on 'policykit-1-gnome'
depends_on 'python'
depends_on 'python-apt' 
depends_on 'libapt-pkg'
depends_on 'python-aptdaemon' 
depends_on 'python-aptdaemon.gtk3widgets'
depends_on 'python-dbus'
depends_on 'python-debtagshw'
depends_on 'python-defer'
depends_on 'python-gi'
depends_on 'python-gi-cairo'
depends_on 'python-xapian'
depends_on 'python-xdg'
depends_on 'software-center-aptdaemon-plugins'
depends_on 'ubuntu-sso-client'
depends_on 'apt-xapian-index'
depends_on 'lsb-release'
depends_on 'software-properties-gtk'
depends_on 'update-notifier'
depends_on 'xz-utils'

  def self.build
    system "echo #!/bin/bash"
  end

  def self.install
    system "install"
  end

  def self.postinstall
    puts
    puts "I need help with this.....".lightblue
    puts
  end
end

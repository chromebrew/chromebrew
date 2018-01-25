require 'package'

class Az < Package
  description 'The Azure CLI 2.0 is Azure\'s new command-line experience for managing Azure resources.'
  homepage 'https://github.com/Azure/azure-cli'
  version '2.0.21'
  source_url 'https://azurecliprod.blob.core.windows.net/install.py'
  source_sha256 '7419f49b066015d863f398198c4ac5ad026f5aa3705e898b552e4e03fc352552'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/az-2.0.21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/az-2.0.21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '93c4890a26e043661059c739dbb3f94ed96dc749fded9d81a39a2963ea1bfb54',
     x86_64: 'efc191b269351ad2f6f2d00a88fc5a781b00f91585d1cb91815ccdb8ac4f63b9',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"
  depends_on 'libffi'
  depends_on 'openssl'

  def self.build
    system "curl -sL https://azurecliprod.blob.core.windows.net/install.py -o install.py"
    system "sed -i '265d' install.py"
    system "sed -i '239,242d' install.py"
    system "sed -i '54,55d' install.py"
    system "sed -i \"s|'lib'|'share'|\" install.py"
    system "sed -i 's,~,#{CREW_DEST_PREFIX},g' install.py"
    system "sed -i \"54iUSER_BASH_RC = '~/.bashrc'\" install.py"
    system "sed -i \"55iUSER_BASH_PROFILE = '~/.bash_profile'\" install.py"
    system "sed -i 's,install_dir = None,install_dir = DEFAULT_INSTALL_DIR,' install.py"
    system "sed -i 's,exec_dir = None,exec_dir = DEFAULT_EXEC_DIR,' install.py"
    system "sed -i 's,rc_file = None,rc_file = USER_BASH_RC,' install.py"
  end

  def self.install
    system "python install.py"
    system "sed -i 's,#{CREW_DEST_DIR},,g' #{CREW_DEST_PREFIX}/bin/az"
  end

  def self.postinstall
    puts
    puts "To add command completion, execute the following:".lightblue
    puts "echo 'source #{CREW_PREFIX}/share/azure-cli/az.completion' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end

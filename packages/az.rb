require 'package'

class Az < Package
  description 'The Azure CLI 2.0 is Azure\'s new command-line experience for managing Azure resources.'
  homepage 'https://github.com/Azure/azure-cli'
  version '2.0.26'
  source_url 'https://azurecliprod.blob.core.windows.net/install.py'
  source_sha256 '7419f49b066015d863f398198c4ac5ad026f5aa3705e898b552e4e03fc352552'

  binary_url ({
  })
  binary_sha256 ({
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

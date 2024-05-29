require 'package'

class Aws_cli < Package
  description 'Universal Command Line Interface for Amazon Web Services'
  homepage 'https://github.com/aws/aws-cli'
  @_ver = '1.32.114'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'groff'
  depends_on 'python3' => :build

  no_compile_needed

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} \
    -I awscli==#{@_ver} --no-warn-script-location"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    @awsbashrc = <<~AWSBASHRCEOF
      # Amazon Web Services CLI bash completion
      source #{CREW_PREFIX}/bin/aws_bash_completer
    AWSBASHRCEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/aws", @awsbashrc)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/zsh.d"
    @awszshrc = <<~AWSZSHRCEOF
      # Amazon Web Services CLI zsh completion
      source #{CREW_PREFIX}/bin/aws_zsh_completer.sh
    AWSZSHRCEOF
    File.write("#{CREW_DEST_PREFIX}/etc/zsh.d/aws", @awszshrc)
  end
end

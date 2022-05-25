require 'package'

class Bashdb < Package
  description 'The Bash Debugger Project is a source-code debugger for bash that follows the gdb command syntax.'
  homepage 'http://bashdb.sourceforge.net/'
  version '5.0-1.1.2-abac'
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bashdb/5.0-1.1.2-abac_armv7l/bashdb-5.0-1.1.2-abac-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bashdb/5.0-1.1.2-abac_armv7l/bashdb-5.0-1.1.2-abac-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bashdb/5.0-1.1.2-abac_i686/bashdb-5.0-1.1.2-abac-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bashdb/5.0-1.1.2-abac_x86_64/bashdb-5.0-1.1.2-abac-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e94ee67c7eb1e025301f2ab16f5588a1903816fccb6b965e83e28e8a4e13c146',
     armv7l: 'e94ee67c7eb1e025301f2ab16f5588a1903816fccb6b965e83e28e8a4e13c146',
       i686: '2642a9fcf547fda5b85ce5472f2637f897b92e162b0955e6113080047895f99e',
     x86_64: '83b0ce54ea38ea941dba8bdbb5ef5f41884fa6abb5faaed5eae00064989f5ae3'
  })

  depends_on 'bash'
  depends_on 'texinfo' => :build

  def self.build
    # No releases yet for Bash 5.1 compatible bashdb, so need git version.
    # Turn off git warnings.
    system 'git config --global advice.detachedHead false'
    system 'git config --global init.defaultBranch main'
    @git_dir = 'bashdb_git'
    @git_hash = 'abac8ee0db03a62d9dc360640e9e5b9648a8fc12'
    @git_url = 'https://git.code.sf.net/p/bashdb/code'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
      system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
      system './configure --help'
      system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
        LDFLAGS='-flto=auto' \
        ./configure \
        #{CREW_OPTIONS} \
        --with-bash=#{CREW_PREFIX}/bin/bash \
        --disable-dependency-tracking"
    end
  end

  def self.install
    Dir.chdir @git_dir do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end

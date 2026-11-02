require 'buildsystems/autotools'

class Bashdb < Autotools
  description 'The Bash Debugger Project is a source-code debugger for bash that follows the gdb command syntax.'
  homepage 'https://bashdb.sourceforge.net/'
  version '5.2-1.2.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/Trepan-Debuggers/bashdb.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '364b5756c974e98c92fc682c0c4212d664d5c4932f1fc22980754e80618a191c',
     armv7l: '364b5756c974e98c92fc682c0c4212d664d5c4932f1fc22980754e80618a191c',
       i686: '2714e30728422b790175d38a77e58493a0a720dc9c2dc2b4cb55959dec000c80',
     x86_64: 'd306d4478157861186cf3823938cf2f22f324666b0ae858da4bd77f5467f2e26'
  })

  def self.patch
    # There is no way to programatically get the plaintext diff from a sourceforge pr, so we embed https://sourceforge.net/p/bashdb/code/merge-requests/11/ here.
    File.write '11.patch', <<~EOF
      diff --git a/configure.ac b/configure.ac
      index 71cf2b7..eb59941 100644
      --- a/configure.ac
      +++ b/configure.ac
      @@ -107,7 +107,7 @@ bash_version=`$SH_PROG --version`
       [bash_minor=`$SH_PROG -c 'echo ${BASH_VERSINFO[1]}'`]
       bash_5_or_greater=no
       case "${bash_major}.${bash_minor}" in
      -  'OK_BASH_VERS' | '5.0' | '5.1')
      +  'OK_BASH_VERS' | '5.0' | '5.1' | '5.2' | '5.3')
           bash_5_or_greater=yes
           ;;
         *)
    EOF
    system 'git apply 11.patch'
  end

  depends_on 'bash'
  depends_on 'texinfo' => :build

  # Setting --with-dbg-main works, but looking at configure.ac reveals that collaboration with upstream is probably required
  # i.e. why does setting a variable described as "location of dbg-main.sh" to the location of bashdb-main.inc fix things?
  # It seems like DBGR_MAIN is confused with BASHDB_MAIN, among other things.
  autotools_configure_options "--with-dbg-main=#{CREW_PREFIX}/share/bashdb-main.inc --with-bash=#{CREW_PREFIX}/bin/bash"
  run_tests
end

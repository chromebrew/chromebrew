require 'buildsystems/autotools'

class Bashdb < Autotools
  description 'The Bash Debugger Project is a source-code debugger for bash that follows the gdb command syntax.'
  homepage 'https://bashdb.sourceforge.net/'
  version '5.0-1.1.2-1f1118d'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.code.sf.net/p/bashdb/code'
  git_hashtag '1f1118dd73f3d3d450d2b644b5b871d545ea0473'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed1f102778d653fca7f36933c0e7b0be6170c23b356613fccc3b4b772f134ed5',
     armv7l: 'ed1f102778d653fca7f36933c0e7b0be6170c23b356613fccc3b4b772f134ed5',
       i686: '70302e22dd1b703ed550c3a15366449f7a9e42b7c62a5cf370e598bf6dc64a17',
     x86_64: '468e44a71a027b55dba4f996b5f4b7e548282933d30356f55a3c7ee1b89cdbcd'
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
      +  'OK_BASH_VERS' | '5.0' | '5.1' | '5.2')
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

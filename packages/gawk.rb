# gawk will break in docker containers in certain situations.
# Add  --ulimit "nofile=$(ulimit -Sn):$(ulimit -Hn)" to work around
# this docker issue that breaks gawk on 32-bit containers:
# https://zouyee.medium.com/why-does-rlimit-nofile-slow-down-your-containerized-application-in-2024-3361671ef5e8
# https://github.com/containerd/containerd/pull/7566#issuecomment-1285417325
# https://github.com/containerd/containerd/pull/7566#issuecomment-1461134737

require 'buildsystems/autotools'

class Gawk < Autotools
  description 'The gawk utility interprets a special-purpose programming language that makes it possible to handle simple data-reformatting jobs with just a few lines of code.'
  homepage 'https://www.gnu.org/software/gawk/'
  version '5.3.2-2'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gawk/gawk-#{version.split('-').first}.tar.xz"
  source_sha256 'ca9c16d3d11d0ff8c69d79dc0b47267e1329a69b39b799895604ed447d3ca90b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '99b58a9b0ce8b9594335bbef3f1123464a9f0ab6fbd0027f64c850a254525907',
     armv7l: '99b58a9b0ce8b9594335bbef3f1123464a9f0ab6fbd0027f64c850a254525907',
       i686: 'ade3834e052404023c02f4a7e8fb6d281c1d0e1f73c442e54b14015a7ee513f7',
     x86_64: '45cd418bd240b9e23741907ca11794657eaf3b2fad88283d5d193ac2e3149dbb'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libsigsegv' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' => :build
  depends_on 'readline' # R

  # Tests appear to have container issues...
  # run_tests unless ARCH == 'i686' || ARCH == 'x86_64'

  autotools_configure_options '--without-libsigsegv-prefix'

  autotools_install_extras do
    # Remove conflict with #{CREW_PREFIX}/bin/awk from mawk package
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/awk"
  end

  def self.patch
    # Suggested patch for docker incompatiblity from gawk mailing list.
    File.write 'pipetable.patch', <<~PIPETABLE_PATCH_EOF
      diff --git a/io.c b/io.c
      index 098a56bf..b46007ae 100644
      --- a/io.c
      +++ b/io.c
      @@ -4604,9 +4604,28 @@ avoid_flush(const char *name)
       typedef struct write_pipe {
       	FILE *fp;
       	pid_t pid;
      +	struct write_pipe *next;
       } write_pipe;

       static write_pipe *open_pipes = NULL;
      +#define PIPE_HASH_SIZE	127
      +
      +static void
      +save_pipe(int fd, FILE *fp, pid_t pid)
      +{
      +	write_pipe *bucket = &open_pipes[fd % PIPE_HASH_SIZE];
      +	write_pipe *wp;
      +
      +	if (bucket->fp == NULL)
      +		wp = bucket;
      +	else {
      +		emalloc(wp, write_pipe *, sizeof(write_pipe));
      +		wp->next = bucket->next;
      +		bucket->next = wp;
      +	}
      +	wp->fp = fp;
      +	wp->pid = pid;
      +}

       /* gawk_popen_write --- open a pipe for writing, set up a FILE * return value. */

      @@ -4623,7 +4642,7 @@ gawk_popen_write(const char *cmd)
       		return NULL;

       	if (open_pipes == NULL) {
      -		int count = getdtablesize();
      +		int count = PIPE_HASH_SIZE;

       		emalloc(open_pipes, write_pipe *, sizeof(write_pipe) * count);
       		memset(open_pipes, 0, sizeof(write_pipe) * count);
      @@ -4653,9 +4672,7 @@ gawk_popen_write(const char *cmd)
       		return NULL;
       	}

      -	int index = pipefds[1];	// use the write file desciptor.
      -	open_pipes[index].pid = childpid;
      -	open_pipes[index].fp = fp;
      +	save_pipe(pipefds[1], fp, childpid);

       	return fp;
       #endif
      @@ -4669,23 +4686,33 @@ gawk_popen_write_close(FILE *fp)
       #if defined(VMS) || defined(__MINGW32__)
       	return pclose(fp);
       #else
      -	int status, index;
      +	write_pipe *wp;
      +	write_pipe *parent;

       	if (open_pipes == NULL || fp == NULL) {
       		errno = EINVAL;
       		return -1;
       	}

      -	index = fileno(fp);
      -	if (open_pipes[index].fp == fp) {
      -		(void) fflush(fp);
      -		(void) fclose(fp);
      -		status = wait_any(open_pipes[index].pid);
      -
      -		open_pipes[index].fp = NULL;
      -		open_pipes[index].pid = 0;
      -
      -		return status;
      +	parent = NULL;
      +	for (wp = &open_pipes[fileno(fp) % PIPE_HASH_SIZE]; wp != NULL;
      +	     wp = wp->next) {
      +		if (wp->fp == fp) {
      +			int status;
      +
      +			(void) fflush(fp);
      +			(void) fclose(fp);
      +			status = wait_any(wp->pid);
      +
      +			wp->fp = NULL;
      +			wp->pid = 0;
      +			if (parent != NULL) {
      +				parent->next = wp->next;
      +				efree(wp);
      +			}
      +			return status;
      +		}
      +		parent = wp;
       	}

       	errno = EBADF;
    PIPETABLE_PATCH_EOF
    system 'patch -Np1 -i pipetable.patch'

    # Fix automake 1.16 requirements.
    system 'grep -rlZ AM_INIT_AUTOMAKE . | xargs -0 sed -i \'s,1.16,1.18,g\''
    system 'grep -rlZ aclocal . | xargs -0 sed -i \'s,1.16,1.18,g\''
  end
end
